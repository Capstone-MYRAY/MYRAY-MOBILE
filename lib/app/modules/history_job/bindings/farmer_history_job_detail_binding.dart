
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/history_job/controllers/farmer_history_job_detail_controller.dart';
import 'package:myray_mobile/app/modules/history_job/history_job_repository.dart';

class FarmerHistoryJobDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FarmerHistoryJobDetailController(), fenix: true);
    Get.lazyPut(() => HistoryJobRepository());
  }

}