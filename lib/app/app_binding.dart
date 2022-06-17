import 'package:get/instance_manager.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';
import 'package:myray_mobile/app/modules/auth/auth_repository.dart';
import 'package:myray_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:myray_mobile/app/modules/auth/controllers/login_controller.dart';
import 'package:myray_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:myray_mobile/app/modules/profile/controllers/farmer_profile_controller.dart';
import 'package:myray_mobile/app/modules/profile/controllers/landowner_profile_controller.dart';
import 'package:myray_mobile/app/modules/profile/profile_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(ApiProvider(), permanent: true);
    Get.put(AuthRepository(), permanent: true);
    Get.lazyPut(
      () => LoginController(authRepository: Get.find()),
      fenix: true,
    );
    Get.lazyPut(() => ProfileRepository());
    Get.lazyPut(() => DashboardController(), fenix: true);
    Get.lazyPut(() => LandownerProfileController());
    Get.lazyPut(() => FarmerProfileController());
  }
}
