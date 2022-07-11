import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/applied_farmer/applied_farmer_repository.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';

mixin AppliedFarmerService {
  final _appliedFarmerRepository = Get.find<AppliedFarmerRepository>();
  Future<bool?> approveFarmer(int appliedId) async {
    bool? isApproveConfirm = await CustomDialog.show(
      message: 'Bạn muốn thuê người này?',
      confirm: () async {
        //close confirm dialog
        Get.back(result: true);
      },
    );

    if (isApproveConfirm == null || !isApproveConfirm) return null;

    return await _appliedFarmerRepository.approveFarmer(appliedId);
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

    return await _appliedFarmerRepository.rejectFarmer(appliedId);
  }
}
