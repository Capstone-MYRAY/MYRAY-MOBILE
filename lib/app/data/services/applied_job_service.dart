import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

mixin AppliedJobService {
  final _appliedRepository = Get.find<AppliedJobRepository>();

  Future<int> checkAmountAppliedJob() async {
    int? numOfAppliedJob = -1;

    try {
      numOfAppliedJob = await _appliedRepository.countAppliedJob();
      return numOfAppliedJob ?? -1;
    } on CustomException catch (e) {
      print('error in applied job service: ${e.message}');
    }
    return -1;
  }
}
