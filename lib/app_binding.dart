import 'package:get/instance_manager.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';
import 'package:myray_mobile/app/data/services/area_repository.dart';
import 'package:myray_mobile/app/data/services/fee_data_service.dart';
import 'package:myray_mobile/app/data/services/post_type_repository.dart';
import 'package:myray_mobile/app/data/services/tree_type_repository.dart';
import 'package:myray_mobile/app/data/services/upload_image_service.dart';
import 'package:myray_mobile/app/modules/applied_farmer/applied_farmer_repository.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/applied_farmer_controller.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/modules/applied_job/controllers/applied_job_controller.dart';
import 'package:myray_mobile/app/modules/auth/auth_repository.dart';
import 'package:myray_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:myray_mobile/app/modules/auth/controllers/login_controller.dart';
import 'package:myray_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:myray_mobile/app/modules/garden/garden_repository.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_home_controller.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_inprogress_job_controller.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_job_post_controller.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_not_start_job_controller.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_controller.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/modules/message/controllers/farmer_message_controller.dart';
import 'package:myray_mobile/app/modules/message/controllers/landowner_message_controller.dart';
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
    Get.lazyPut(() => JobPostRepository(), fenix: true);
    Get.lazyPut(() => PaymentHistoryRepository(), fenix: true);
    Get.lazyPut(() => FeeDataService(), fenix: true);
    Get.lazyPut(() => AppliedFarmerRepository(), fenix: true);
    Get.lazyPut(() => LandownerProfileController(), fenix: true);
    Get.lazyPut(() => LandownerJobPostController(), fenix: true);
    Get.lazyPut(() => LandownerMessageController(), fenix: true);
    Get.lazyPut(() => FarmerMessageController(), fenix: true);
    Get.lazyPut(() => AppliedFarmerController(), fenix: true);
    Get.lazyPut(() => FarmerProfileController(), fenix: true);
    Get.lazyPut(() => FarmerHomeController(), fenix: true);
    Get.lazyPut(() => FarmerJobPostController(), fenix: true);
    Get.lazyPut(() => AppliedFarmerController(), fenix: true);
    Get.lazyPut(() => AppliedJobController(), fenix: true);
    Get.lazyPut(() => AppliedJobRepository(), fenix: true);
    Get.lazyPut(() => FarmerInprogressJobController(), fenix: true);
    Get.lazyPut(() => FarmerNotStartJobController(), fenix: true);
  }
}
