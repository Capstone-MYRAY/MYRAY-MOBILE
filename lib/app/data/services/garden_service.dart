import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/modules/garden/garden_repository.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/information_dialog.dart';

mixin GardenService {
  Future<bool?> deleteGarden(Garden garden, RxList<Garden> gardens) async {
    final gardenRepository = Get.find<GardenRepository>();
    bool canDelete = await gardenRepository.canDelete(garden.id);
    if (!canDelete) {
      // show error
      InformationDialog.showDialog(
        msg: AppMsg.MSG4015,
      );
      return null;
    }

    bool? isDeleteConfirm = await CustomDialog.show(
      message: AppMsg.MSG4013,
      confirm: () async {
        //close confirm dialog
        Get.back(result: true);
      },
    );

    if (isDeleteConfirm == null || !isDeleteConfirm) return false;

    final success = await gardenRepository.delete(garden.id);
    if (!success) {
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
      return false;
    }

    //update garden list
    return gardens.remove(garden);
  }
}
