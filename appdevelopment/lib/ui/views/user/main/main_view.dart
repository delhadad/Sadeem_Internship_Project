import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:intern/ui/views/user/main/vendor_list_view.dart';
import 'package:intern/ui/widgets/stateless/app_bar.dart';
import 'package:stacked/stacked.dart';
import '../../../widgets/stateful/drawer/customer_drawer_menu.dart';
import 'main_view_model.dart';

@RoutePage()
class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // LocationData? currentLocation;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onViewModelReady: (model) async {
        await model.init(
          context,
        );
      },
      viewModelBuilder: () => MainViewModel(),
      builder: (context, model, child) => model.isBusy
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              drawer: CustomerDrawerMenu(),
              appBar: MyAppBar(
                toolbarExtraHeight: 0,
              ),
              body: SingleChildScrollView(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Expanded(
                        child: VendorListView(
                      parameters: {},
                    ))
                  ],
                ),
              )),
            ),
    );
  }
}
