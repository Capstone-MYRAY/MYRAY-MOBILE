import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/auth.dart';
import 'package:myray_mobile/app/modules/auth/views/enter_password_view.dart';
import 'package:myray_mobile/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:myray_mobile/app/modules/dashboard/views/farmer_dashboard_view.dart';
import 'package:myray_mobile/app/modules/dashboard/views/landowner_dashboard_view.dart';
import 'package:myray_mobile/app/modules/garden/bindings/garden_home_binding.dart';
import 'package:myray_mobile/app/modules/garden/views/garden_home_view.dart';
import 'package:myray_mobile/app/modules/profile/views/farmer_profile_detail.dart';
import 'package:myray_mobile/app/modules/profile/views/landowner_profile_details_view.dart';
import 'package:myray_mobile/init_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.init;

  static final routes = [
    GetPage(
      name: _Paths.init,
      page: () => const InitView(),
    ),
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
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.signup,
      page: () => const SignupView(),
      binding: SignupBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.enterOtp,
      page: () => const EnterOtpView(),
      binding: EnterOtpBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.resetPassword,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.enterPassword,
      page: () => const EnterPasswordView(),
      binding: SignupBinding(),
      transition: Transition.rightToLeft,
    ),

    //landowner
    GetPage(
      name: _Paths.landownerDashboard,
      page: () => const LandownerDashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.landownerProfile,
      page: () => const LandownerProfileDetailsView(),
    ),
    GetPage(
      name: _Paths.gardenHome,
      page: () => const GardenHomeView(),
      binding: GardenHomeBinding(),
    ),

    //farmer
    GetPage(
      name: _Paths.farmerDashboard,
      page: () => const FarmerDashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.farmerProfile,
      page: () => const FarmerProfileDetailView(),
      transition: Transition.downToUp
    )
  ];
}
