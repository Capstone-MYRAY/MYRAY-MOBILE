import 'package:get/get.dart';
import 'package:myray_mobile/app/data/services/extend_job_repository.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';

mixin ExtendJobService {
  final _extendJobRepository = Get.find<ExtendJobRepository>();

  Future<bool> approveExtend(int requestId) async {
    bool? isApproveConfirm = await CustomDialog.show(
      message: 'Bạn muốn chấp nhận yêu cầu này?',
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
      message: 'Bạn muốn chấp nhận yêu cầu này?',
      confirm: () async {
        //close confirm dialog
        Get.back(result: true);
      },
    );

    if (isApproveConfirm == null || !isApproveConfirm) return false;

    return await _extendJobRepository.rejectExtend(requestId);
  }
}
