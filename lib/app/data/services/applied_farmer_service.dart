import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer_models.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/applied_farmer/applied_farmer_repository.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/information_dialog.dart';

mixin AppliedFarmerService {
  final _appliedFarmerRepository = Get.find<AppliedFarmerRepository>();
  Future<bool> canEnd(JobPost jobPost) async {
    if (Utils.equalsIgnoreCase(jobPost.type, JobType.payPerHourJob.name)) {
      return true;
    } //if job post is pay per hour job

    final data = GetAppliedFarmerRequest(
      page: 1.toString(),
      pageSize: 1.toString(),
      status: AppliedFarmerStatus.approved,
      jobPostId: jobPost.id.toString(),
    );

    final appliedFarmers = await _appliedFarmerRepository.getAppliedByJob(data);
    if (appliedFarmers == null || appliedFarmers.appliedFarmers == null) {
      throw CustomException('Error');
    }

    if (appliedFarmers.appliedFarmers!.isEmpty) return true;

    InformationDialog.showDialog(
        msg:
            'Bạn vẫn chưa xác nhận trả lương cho nông dân, không thể kết thúc công việc.');

    return false;
  }

  bool canApprove(JobPost jobPost) {
    if (jobPost.status == JobPostStatus.shortHanded.index) {
      return true;
    }

    return false;
  }

  Future<int?> approveFarmer(int appliedId) async {
    bool? isApproveConfirm = await CustomDialog.show(
      message: 'Bạn muốn thuê người này?',
      confirm: () async {
        //close confirm dialog
        Get.back(result: true);
      },
    );

    if (isApproveConfirm == null || !isApproveConfirm) return 0;

    try {
      EasyLoading.show();
      int? status = await _appliedFarmerRepository.approveFarmer(appliedId);
      return status;
    } catch (e) {
      throw Exception('Có lỗi xảy ra');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<bool?> rejectFarmer(int appliedId) async {
    bool? isApproveConfirm = await CustomDialog.show(
      message: 'Bạn không muốn thuê người này?',
      confirm: () async {
        //close confirm dialog
        Get.back(result: true);
      },
    );

    if (isApproveConfirm == null || !isApproveConfirm) return null;

    try {
      EasyLoading.show();
      bool result = await _appliedFarmerRepository.rejectFarmer(appliedId);
      return result;
    } catch (e) {
      throw Exception('Có lỗi xảy ra');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
