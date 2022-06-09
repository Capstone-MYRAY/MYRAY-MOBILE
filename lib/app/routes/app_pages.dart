import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/bindings/login_binding.dart';
import 'package:myray_mobile/app/modules/auth/bindings/signup_binding.dart';
import 'package:myray_mobile/app/modules/auth/views/choose_role_view.dart';
import 'package:myray_mobile/app/modules/auth/views/forgot_password_view.dart';
import 'package:myray_mobile/app/modules/auth/views/login_view.dart';
import 'package:myray_mobile/app/modules/auth/views/signup_view.dart';
import 'package:myray_mobile/app/modules/home/bindings/home_binding.dart';
import 'package:myray_mobile/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.chooseRole,
      page: () => const ChooseRoleView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.forgotPassword,
      page: () => const ForgotPasswordView(),
    ),
    GetPage(
      name: _Paths.signup,
      page: () => const SignupView(),
      binding: SignupBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
