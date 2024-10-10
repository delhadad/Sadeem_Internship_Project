import 'package:auto_route/auto_route.dart';
import 'package:intern/core/constant/api_routes.dart';
import 'package:intern/core/enums/http_request_type.dart';
import 'package:intern/core/models/user/user.dart';
import 'package:intern/core/repositories/magical_repository.dart';
import 'package:intern/core/services/navigation/navigation_service.dart';
import 'package:intern/locator.dart';
import 'package:intern/ui/router.gr.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/mixins/validators.dart';

class SignupViewModel extends BaseViewModel with Validators {
  User user = User();
  Future<void> init() async {
    setBusy(true);
    setBusy(false);
  }

  Future<void> signUp() async {
    try {
      user = await locator<MagicalRepository>().handelRequest(
          model: User(),
          parameters: {
            'email': '${user.email}',
            'name': '${user.name}',
            'password': '${user.password}'
          },
          methodType: HTTPMethodType.POST_FORM_DATA,
          route: ApiRoutes.register);
      locator<NavigationService>().pushNamed(LoginViewRoute());
    } catch (e) {
      print('SignUpViewModel.signUp');
      print('Error');
    }
  }
}
