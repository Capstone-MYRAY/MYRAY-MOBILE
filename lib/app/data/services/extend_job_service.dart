import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/extend_history/extend_job_repository.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';

mixin ExtendJobService {
  final _extendJobRepository = Get.find<ExtendJobRepository>();

  Future<bool> approveExtend(int requestId) async {
    bool? isApproveConfirm = await CustomDialog.show(
      message: AppMsg.MSG4035,
      confirm: () async {
        //close confirm dialog
        Get.back(result: true);
      },
    );

    if (isApproveConfirm == null || !isApproveConfirm) return false;

    return await _extendJobRepository.approveExtend(requestId);
  }

  Future<bool> rejectExtend(int requestId) async {
    bool? isApproveConfirm = await CustomDialog.show(
      message: AppMsg.MSG4036,
      confirm: () async {
        //close confirm dialog
        Get.back(result: true);
      },
    );

    if (isApproveConfirm == null || !isApproveConfirm) return false;

    return await _extendJobRepository.rejectExtend(requestId);
  }
}
