#![no_std]
#![no_main]

use embedded_nal_async::{AddrType, Dns, TcpConnect};
use esp_backtrace as _;
use esp_hal::{
    clock::ClockControl,
    delay::Delay,
    gpio::{GpioPin, Io, Level, Output},
    peripherals::Peripherals,
    prelude::*,
    system::SystemControl,
    timer::timg::TimerGroup,
};
use esp_println::println;

use esp_wifi::{
    initialize,
    wifi::{
        self, new_with_mode, ClientConfiguration, Configuration, WifiController, WifiDevice,
        WifiEvent, WifiStaDevice, WifiState,
    },
    EspWifiInitFor,
};

use embassy_net::{
    dns::DnsSocket,
    tcp::client::{TcpClient, TcpClientState},
    Stack, StackResources,
};
use rust_mqtt::{
    client::{
        client::MqttClient,
        client_config::{ClientConfig, MqttVersion},
    },
    utils::rng_generator::CountingRng,
};

extern crate alloc;
use core::{mem::MaybeUninit, str::FromStr};
use embassy_executor::task;
use embassy_time::{Duration, Timer};
use esp_hal_embassy::Executor;
use heapless::String;

#[global_allocator]
static ALLOCATOR: esp_alloc::EspHeap = esp_alloc::EspHeap::empty();

static EXECUTOR: static_cell::StaticCell<Executor> = static_cell::StaticCell::new();
static NETWORK_STACK: static_cell::StaticCell<Stack<WifiDevice<'_, WifiStaDevice>>> =
    static_cell::StaticCell::new();
static STACK_RESOURCE: static_cell::StaticCell<StackResources<5>> = static_cell::StaticCell::new();
#[entry]
fn main() -> ! {
    let peripherals = Peripherals::take();
    let system = SystemControl::new(peripherals.SYSTEM);

    let clocks = ClockControl::max(system.clock_control).freeze();
    let delay = Delay::new(&clocks);
    let io = Io::new(peripherals.GPIO, peripherals.IO_MUX);
    let led = Output::new(io.pins.gpio23, Level::Low);

    esp_println::logger::init_logger_from_env();

    let timg0 = esp_hal::timer::timg::TimerGroup::new(peripherals.TIMG0, &clocks);
    let _init = esp_wifi::initialize(
        esp_wifi::EspWifiInitFor::Wifi,
        timg0.timer0,
        esp_hal::rng::Rng::new(peripherals.RNG),
        peripherals.RADIO_CLK,
        &clocks,
    )
    .unwrap();

    let wifi = peripherals.WIFI;
    let (wifi_interface, controller) =
        esp_wifi::wifi::new_with_mode(&_init, wifi, WifiStaDevice).unwrap();
    let config = embassy_net::Config::dhcpv4(Default::default());

    let stack_resources = STACK_RESOURCE.init(StackResources::<5>::new());

    let stack: &'static Stack<WifiDevice<'_, WifiStaDevice>> =
        NETWORK_STACK.init(Stack::new(wifi_interface, config, stack_resources, 1234));

    let executor: &mut Executor = EXECUTOR.init(Executor::new());
    let timg1 = TimerGroup::new(peripherals.TIMG1, &clocks);
    esp_hal_embassy::init(&clocks, timg1.timer0);

    executor.run(|spawner| {
        spawner.spawn(wifi_connection(controller)).unwrap();
        spawner.spawn(run_network(&stack)).unwrap();
        spawner.spawn(mqtt_task(&stack, led)).unwrap();
        spawner.spawn(some_task()).unwrap();
    });
}

#[task]
async fn some_task() -> ! {
    loop {
        Timer::after_millis(1000).await;
    }
}

#[task]
async fn wifi_connection(mut controller: WifiController<'static>) {
    println!("[start conecting wifi]");
    loop {
        match wifi::get_wifi_state() {
            WifiState::StaConnected => {
                controller.wait_for_event(WifiEvent::StaDisconnected).await;
                Timer::after(Duration::from_millis(5000)).await;
            }
            _ => {}
        }
        let ssid = String::<32>::from_str("Wokwi-GUEST").unwrap();

        println!("[connect to {:?}]", ssid);
        if !matches!(controller.is_started(), Ok(true)) {
            let client_config = Configuration::Client(ClientConfiguration {
                ssid: ssid,
                //  password: String::<64>::from_str("").unwrap(),
                auth_method: wifi::AuthMethod::None,
                ..Default::default()
            });
            controller.set_configuration(&client_config).unwrap();
            println!("starting wifi");
            controller.start().await.unwrap();
            println!("wifi started");
        }
        println!("about the connect...");

        match controller.connect().await {
            Ok(_) => {
                println!("wifi connected");
            }
            Err(e) => {
                println!("Failed to connect to wifi: {e:?}");
                Timer::after_millis(5000).await;
            }
        }
    }
}

#[task]
async fn run_network(stack: &'static Stack<WifiDevice<'static, WifiStaDevice>>) {
    stack.run().await
}

const BUFFER_SIZE: usize = 1024;

#[task]
async fn mqtt_task(
    stack: &'static Stack<WifiDevice<'static, WifiStaDevice>>,
    mut led: Output<'static, GpioPin<23>>, // Explicit 'static lifetime for led
) {
    println!("[MQTT_TASK]");
    loop {
        if !stack.is_link_up() {
            Timer::after_millis(500).await;
            continue;
        }
        let host = "broker.emqx.io";
        let dns_socket = DnsSocket::new(stack);
        let ip = loop {
            if let Ok(ip) = dns_socket.get_host_by_name(host, AddrType::Either).await {
                break ip;
            }
            Timer::after_millis(500).await;
        };
        println!("[host up is {:?}]", ip);
        let state: TcpClientState<5, BUFFER_SIZE, BUFFER_SIZE> = TcpClientState::new();
        let tcp_client = TcpClient::new(stack, &state);
        let tcp_connection = match tcp_client
            .connect(embedded_nal_async::SocketAddr::new(ip, 1883))
            .await
        {
            Ok(connection) => connection,
            Err(E) => {
                println!("Error: {:?}", E);
                return ();
            }
        };
        println!("[connected to the server]");
        let mut send_buffer = [0_u8; BUFFER_SIZE];
        let mut receive_buffer = [0_u8; BUFFER_SIZE];
        let mut mqtt_client_config: ClientConfig<'_, 5, CountingRng> =
            ClientConfig::new(MqttVersion::MQTTv5, CountingRng(12345));

        mqtt_client_config.add_client_id("mqttx_ddd202554789dddd");

        let mut mqtt_client = MqttClient::new(
            tcp_connection,
            &mut send_buffer,
            BUFFER_SIZE,
            &mut receive_buffer,
            BUFFER_SIZE,
            mqtt_client_config,
        );

        println!("[connected to broker]");
        mqtt_client.connect_to_broker().await.unwrap();
        mqtt_client
            .subscribe_to_topic("embedded_backend")
            .await
            .unwrap();
        loop {
            println!("[mqtt loop]");
            match mqtt_client.receive_message().await {
                Ok((topic, payload)) => {
                    println!("[topic: {}]", topic);
                    println!("data: {:?}", payload);

                    if payload.len() > 0 {
                        if payload[0] as char == '1' {
                            led.set_high(); // LED ON
                        } else if payload[0] as char == '0' {
                            led.set_low(); // LED OFF
                        }
                    }
                }
                Err(e) => {
                    println!("Error: {:?}", e);
                    break;
                }
            }
            // Timer::after_millis(1000).await
        }
    }
}
