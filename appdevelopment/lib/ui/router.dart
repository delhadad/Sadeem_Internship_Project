import 'package:auto_route/auto_route.dart';
import 'package:intern/ui/router.gr.dart';
import 'package:intern/ui/views/auth/signup/signup_view.dart';

@AutoRouterConfig(replaceInRouteName: 'View', generateForDir: ['lib'])
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: StartUpViewRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: LoginViewRoute.page,
          path: '/login',
        ),
        AutoRoute(page: AboutViewRoute.page),
        AutoRoute(
          page: MainViewRoute.page,
        ),
        //SignUpView
        AutoRoute(
          page: SignUpViewRoute.page,
        ),
        //VendorView
        AutoRoute(
          page: VendorViewRoute.page,
        ),
      ];
}
