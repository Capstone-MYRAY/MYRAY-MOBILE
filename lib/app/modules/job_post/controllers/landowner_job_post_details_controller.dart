import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history_models.dart';
import 'package:myray_mobile/app/modules/garden/garden_repository.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_controller.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/modules/payment_history/payment_history_repository.dart';
import 'package:myray_mobile/app/modules/profile/controllers/landowner_profile_controller.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';

class LandownerJobPostDetailsController extends GetxController {
  final Rx<JobPost> jobPost;
  final RxList<PaymentHistory> paymentHistories = RxList([]);
  final _gardenRepository = Get.find<GardenRepository>();
  final _paymentHistoryRepository = Get.find<PaymentHistoryRepository>();
  final _jobPostRepository = Get.find<JobPostRepository>();
  final _jobPostController = Get.find<LandownerJobPostController>();
  final _profile = Get.find<LandownerProfileController>();

  LandownerJobPostDetailsController({required this.jobPost});

  navigateToUpdateForm() {
    Get.toNamed(Routes.jobPostForm, arguments: {
      Arguments.action: Activities.update,
      Arguments.item: jobPost.value,
      Arguments.tag: Get.arguments[Arguments.tag],
    });
  }

  viewGardenDetails() async {
    //get garden by id
    Garden? garden = await _gardenRepository.getById(jobPost.value.gardenId);

    if (garden == null) {
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );

      return;
    }

    Get.toNamed(Routes.gardenDetails, arguments: {
      Arguments.tag: garden.id.toString(),
      Arguments.item: garden,
      Arguments.action: Activities.view,
    });
  }

  Future<bool?> getPaymentHistory() async {
    paymentHistories.clear();
    final int _accountId = AuthCredentials.instance.user!.id!;
    final _data = GetPaymentHistoryRequest(
      page: 1.toString(),
      pageSize: 10.toString(),
      jobPostId: jobPost.value.id.toString(),
      sortColumn: PaymentHistorySortColumn.createdDate,
      orderBy: SortOrder.descending,
    );

    final _response =
        await _paymentHistoryRepository.getList(_accountId, _data);
    if (_response == null || _response.paymentHistories!.isEmpty) {
      return null;
    }

    paymentHistories.addAll(_response.paymentHistories!);
    return true;
  }

  deleteJob() {
    CustomDialog.show(
        message: AppMsg.MSG4007,
        confirm: () async {
          final _success = await _jobPostRepository.deleteJob(jobPost.value.id);

          //close dialog
          Get.back();

          if (!_success) {
            CustomSnackbar.show(
              title: AppStrings.titleError,
              message: 'Có lỗi xảy ra',
              backgroundColor: AppColors.errorColor,
            );
            return;
          }

          //update balance
          _profile.calBalance();

          //update jobpost list
          _jobPostController.jobPosts.remove(jobPost.value);

          //close details screen
          Get.back();

          CustomSnackbar.show(
            title: AppStrings.titleSuccess,
            message: AppMsg.MSG4008,
          );
        });
  }

  cancelJob() {
    CustomDialog.show(
        message: AppMsg.MSG4009,
        confirm: () async {
          final _success = await _jobPostRepository.cancelJob(jobPost.value.id);

          //close dialog
          Get.back();

          if (!_success) {
            CustomSnackbar.show(
              title: AppStrings.titleError,
              message: 'Có lỗi xảy ra',
              backgroundColor: AppColors.errorColor,
            );
            return;
          }

          //update jobpost
          jobPost.value = jobPost.value..status = JobPostStatus.cancel.index;

          //update jobpost list
          _jobPostController.updateJobPosts(jobPost.value);

          CustomSnackbar.show(
            title: AppStrings.titleSuccess,
            message: AppMsg.MSG4010,
          );
        });
  }

  Future<void> onRefresh() async {}
}
