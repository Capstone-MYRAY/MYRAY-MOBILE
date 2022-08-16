import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/status.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer_models.dart';
import 'package:myray_mobile/app/data/services/applied_farmer_service.dart';
import 'package:myray_mobile/app/data/services/bookmark_service.dart';
import 'package:myray_mobile/app/data/services/message_service.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/applied_farmer_controller.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/information_dialog.dart';

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
    try {
      bool approvable = canApprove(appliedFarmer.value.jobPost);

      if (!approvable) {
        throw CustomException(
            'Công việc này đã đủ người, không thể nhận thêm.');
      }

      int? jobPostStatus = await approveFarmer(appliedFarmer.value.id);

      //user cancel action
      if (jobPostStatus == null) throw Exception('Có lỗi xảy ra');

      if (jobPostStatus == 0) return;

      //update job post status
      if (jobPostStatus == JobPostStatus.enough.index) {
        final jobPostController = Get.find<LandownerJobPostController>();
        jobPostController.updateJobPosts(
            appliedFarmer.value.jobPost..status = jobPostStatus);
      }

      //update status
      appliedFarmer.value.status = AppliedFarmerStatus.approved.index;
      appliedFarmer.refresh();

      //refresh list
      final appliedFarmerController = Get.find<AppliedFarmerController>();
      appliedFarmerController.onRefresh();
    } on CustomException catch (e) {
      InformationDialog.showDialog(
        msg: e.message,
      );
    } catch (e) {
      print('Approve Error: ${e.toString()}');
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  reject() async {
    try {
      bool? success = await rejectFarmer(appliedFarmer.value.id);
      // EasyLoading.dismiss();

      //user cancel action
      if (success == null) return;

      if (!success) throw Exception('Có lỗi xảy ra');

      //update status
      appliedFarmer.value.status = AppliedFarmerStatus.rejected.index;

      //remove this farmer from list
      final appliedFarmerController = Get.find<AppliedFarmerController>();
      appliedFarmerController.removeItem(appliedFarmer.value);
      appliedFarmer.refresh();
    } catch (e) {
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }
}
