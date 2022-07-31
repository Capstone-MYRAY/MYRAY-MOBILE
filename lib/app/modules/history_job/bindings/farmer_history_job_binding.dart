
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/history_job/controllers/farmer_history_job_controller.dart';
import 'package:myray_mobile/app/modules/history_job/history_job_repository.dart';

class FarmerHistoryJobBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FarmerHistoryJobController(), fenix: true);
    Get.lazyPut(() => HistoryJobRepository());
  }

}