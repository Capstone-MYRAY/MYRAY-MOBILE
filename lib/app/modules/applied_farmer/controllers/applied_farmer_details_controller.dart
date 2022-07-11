import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/status.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer_models.dart';
import 'package:myray_mobile/app/data/services/applied_farmer_service.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/applied_farmer_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class AppliedFarmerDetailsController extends GetxController
    with AppliedFarmerService {
  final Rx<AppliedFarmer> appliedFarmer;

  AppliedFarmerDetailsController({required this.appliedFarmer});

  approve() async {
    bool? success = await approveFarmer(appliedFarmer.value.id);

    //user cancel action
    if (success == null) return;

    if (!success) {
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
      return;
    }

    //update status
    appliedFarmer.value.status = AppliedFarmerStatus.approved.index;

    //remove this farmer from list
    final _appliedFarmerController = Get.find<AppliedFarmerController>();
    _appliedFarmerController.removeItem(appliedFarmer.value);

    //update UI
    update();
  }

  reject() async {
    bool? success = await rejectFarmer(appliedFarmer.value.id);

    //user cancel action
    if (success == null) return;

    if (!success) {
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
      return;
    }

    //update status
    appliedFarmer.value.status = AppliedFarmerStatus.rejected.index;

    //remove this farmer from list
    final _appliedFarmerController = Get.find<AppliedFarmerController>();
    _appliedFarmerController.removeItem(appliedFarmer.value);

    //update UI
    update();
  }
}
