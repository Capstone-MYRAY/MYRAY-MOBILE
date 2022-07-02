import 'package:get/instance_manager.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';
import 'package:myray_mobile/app/data/services/area_repository.dart';
import 'package:myray_mobile/app/data/services/fee_data_service.dart';
import 'package:myray_mobile/app/data/services/post_type_repository.dart';
import 'package:myray_mobile/app/data/services/tree_type_repository.dart';
import 'package:myray_mobile/app/data/services/upload_image_service.dart';
import 'package:myray_mobile/app/modules/auth/auth_repository.dart';
import 'package:myray_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:myray_mobile/app/modules/auth/controllers/login_controller.dart';
import 'package:myray_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:myray_mobile/app/modules/garden/garden_repository.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_home_controller.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_job_post_controller.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_controller.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/modules/payment_history/payment_history_repository.dart';
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
    Get.lazyPut(() => ProfileRepository(), fenix: true);
    Get.lazyPut(() => DashboardController(), fenix: true);
    Get.lazyPut(() => GardenRepository(), fenix: true);
    Get.lazyPut(() => AreaRepository(), fenix: true);
    Get.lazyPut(() => TreeTypeRepository(), fenix: true);
    Get.lazyPut(() => PostTypeRepository(), fenix: true);
    Get.lazyPut(() => UploadImageService(), fenix: true);
    Get.lazyPut(() => PaymentHistoryRepository(), fenix: true);
    Get.lazyPut(() => FeeDataService(), fenix: true);
    Get.lazyPut(() => LandownerProfileController());
    Get.lazyPut(() => LandownerJobPostController());
    Get.lazyPut(() => FarmerProfileController());
    Get.lazyPut(() => FarmerHomeController());
    Get.lazyPut(() => JobPostRepository());
    Get.lazyPut(() => FarmerJobPostController());
  }
}
