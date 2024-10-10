// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:intern/core/models/vendor/vendor.dart' as _i9;
import 'package:intern/ui/views/auth/login/login_view.dart' as _i2;
import 'package:intern/ui/views/auth/signup/signup_view.dart' as _i4;
import 'package:intern/ui/views/startup/start_up_view.dart' as _i5;
import 'package:intern/ui/views/user/about/about_view.dart' as _i1;
import 'package:intern/ui/views/user/main/main_view.dart' as _i3;
import 'package:intern/ui/views/user/vendor/view.dart' as _i7;
import 'package:intern/ui/widgets/stateful/vendor/view.dart' as _i6;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    AboutViewRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AboutView(),
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.LoginView(),
      );
    },
    MainViewRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.MainView(),
      );
    },
    SignUpViewRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SignUpView(),
      );
    },
    StartUpViewRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.StartUpView(),
      );
    },
    VendorCardRoute.name: (routeData) {
      final args = routeData.argsAs<VendorCardRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.VendorCard(vendor: args.vendor),
      );
    },
    VendorViewRoute.name: (routeData) {
      final args = routeData.argsAs<VendorViewRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.VendorView(vendor: args.vendor),
      );
    },
  };
}

/// generated route for
/// [_i1.AboutView]
class AboutViewRoute extends _i8.PageRouteInfo<void> {
  const AboutViewRoute({List<_i8.PageRouteInfo>? children})
      : super(
          AboutViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutViewRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginView]
class LoginViewRoute extends _i8.PageRouteInfo<void> {
  const LoginViewRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LoginViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginViewRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.MainView]
class MainViewRoute extends _i8.PageRouteInfo<void> {
  const MainViewRoute({List<_i8.PageRouteInfo>? children})
      : super(
          MainViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainViewRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SignUpView]
class SignUpViewRoute extends _i8.PageRouteInfo<void> {
  const SignUpViewRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SignUpViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpViewRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.StartUpView]
class StartUpViewRoute extends _i8.PageRouteInfo<void> {
  const StartUpViewRoute({List<_i8.PageRouteInfo>? children})
      : super(
          StartUpViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartUpViewRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.VendorCard]
class VendorCardRoute extends _i8.PageRouteInfo<VendorCardRouteArgs> {
  VendorCardRoute({
    required _i9.Vendor? vendor,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          VendorCardRoute.name,
          args: VendorCardRouteArgs(vendor: vendor),
          initialChildren: children,
        );

  static const String name = 'VendorCardRoute';

  static const _i8.PageInfo<VendorCardRouteArgs> page =
      _i8.PageInfo<VendorCardRouteArgs>(name);
}

class VendorCardRouteArgs {
  const VendorCardRouteArgs({required this.vendor});

  final _i9.Vendor? vendor;

  @override
  String toString() {
    return 'VendorCardRouteArgs{vendor: $vendor}';
  }
}

/// generated route for
/// [_i7.VendorView]
class VendorViewRoute extends _i8.PageRouteInfo<VendorViewRouteArgs> {
  VendorViewRoute({
    required _i9.Vendor vendor,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          VendorViewRoute.name,
          args: VendorViewRouteArgs(vendor: vendor),
          initialChildren: children,
        );

  static const String name = 'VendorViewRoute';

  static const _i8.PageInfo<VendorViewRouteArgs> page =
      _i8.PageInfo<VendorViewRouteArgs>(name);
}

class VendorViewRouteArgs {
  const VendorViewRouteArgs({required this.vendor});

  final _i9.Vendor vendor;

  @override
  String toString() {
    return 'VendorViewRouteArgs{vendor: $vendor}';
  }
}
