import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/status.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer_models.dart';
import 'package:myray_mobile/app/data/services/applied_farmer_service.dart';
import 'package:myray_mobile/app/data/services/bookmark_service.dart';
import 'package:myray_mobile/app/data/services/message_service.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/applied_farmer_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class AppliedFarmerDetailsController extends GetxController
    with AppliedFarmerService, MessageService, BookmarkService {
  final Rx<AppliedFarmer> appliedFarmer;
  var isBookmarked = false.obs;

  AppliedFarmerDetailsController({required this.appliedFarmer});

  void navigateToChatScreen() {
    final fromId = AuthCredentials.instance.user?.id ?? 0;
    final toId = appliedFarmer.value.userInfo.id ?? 0;
    final jobPostId = appliedFarmer.value.jobPost.id;
    final toAvatar = appliedFarmer.value.userInfo.imageUrl;
    navigateToP2PMessageScreen(
        fromId,
        toId,
        jobPostId,
        appliedFarmer.value.userInfo.fullName ?? '',
        appliedFarmer.value.jobPost.title,
        toAvatar: toAvatar);
  }

  onToggleBookmark() {
    try {
      if (isBookmarked.value) {
        unBookmark(appliedFarmer.value.userInfo.id!);
        isBookmarked.value = false;
      } else {
        bookmark(appliedFarmer.value.userInfo.id!);
        isBookmarked.value = true;
      }
    } catch (e) {
      print('Bookmark error: ${e.toString()}');
    }
  }

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
    final appliedFarmerController = Get.find<AppliedFarmerController>();
    appliedFarmerController.removeItem(appliedFarmer.value);
    appliedFarmer.refresh();
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
    final appliedFarmerController = Get.find<AppliedFarmerController>();
    appliedFarmerController.removeItem(appliedFarmer.value);
    appliedFarmer.refresh();
  }
}
