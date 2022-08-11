import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_request.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_response.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

mixin AppliedJobService {
  final _appliedRepository = Get.find<AppliedJobRepository>();

  Future<int> checkAmountAppliedJob() async {
    GetAppliedJobPostList? list;

    GetAppliedJobRequest data = GetAppliedJobRequest(
      status: AppliedFarmerStatus.pending,
      page: 1.toString(),
      pageSize: 20.toString(),
    );

    try {
      list = await _appliedRepository.getAppliedJobList(data);
      if(list == null || list.listObject == null || list.listObject!.isEmpty){
        return -1;
      }
      return list.listObject!.length;
    } on CustomException catch (e) {
      print('error in applied job service: $e');
    }
    return -1;
  }
}
