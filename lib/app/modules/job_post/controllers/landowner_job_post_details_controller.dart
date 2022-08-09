import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/fee_data.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/data/models/job_post/extend_expired_date_request.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history_models.dart';
import 'package:myray_mobile/app/data/services/services.dart';
import 'package:myray_mobile/app/modules/attendance/attendance_repository.dart';
import 'package:myray_mobile/app/modules/garden/garden_repository.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_controller.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/landowner_job_post_details/extend_expired_date_dialog.dart';
import 'package:myray_mobile/app/modules/payment_history/payment_history_repository.dart';
import 'package:myray_mobile/app/modules/profile/controllers/landowner_profile_controller.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';

class LandownerJobPostDetailsController extends GetxController {
  final Rx<JobPost> jobPost;
  final List<PaymentHistory> paymentHistories = [];
  final _gardenRepository = Get.find<GardenRepository>();
  final _paymentHistoryRepository = Get.find<PaymentHistoryRepository>();
  final _jobPostRepository = Get.find<JobPostRepository>();
  final _jobPostController = Get.find<LandownerJobPostController>();
  final _profile = Get.find<LandownerProfileController>();
  final _feeDataService = Get.find<FeeDataService>();
  final _attendanceRepository = Get.find<AttendanceRepository>();

  final String workInformation = 'WorkInformation';
  final String workPlaceInformation = 'WorkPlaceInformation';
  final String postInformation = 'PostInformation';
  final String paymentHistoryInformation = 'PaymentInformation';
  final String buttonControls = 'ButtonControls';

  var totalPostingFee = 0.0.obs;
  var totalPayingSalary = 0.0.obs;

  LandownerJobPostDetailsController({required this.jobPost});

  navigateToUpdateForm() {
    Get.toNamed(Routes.jobPostForm, arguments: {
      Arguments.action: Activities.update,
      Arguments.item: jobPost.value,
      Arguments.tag: Get.arguments[Arguments.tag],
    });
  }

  finishJob() async {
    try {
      final isConfirmed = await CustomDialog.show(
          confirm: () => Get.back(result: true), message: AppMsg.MSG4037);

      if (isConfirmed == null || !isConfirmed) return;

      final success = await _jobPostRepository.finishJob(jobPost.value.id);
      if (!success) throw Exception('Có lỗi xảy ra');

      //update details ui
      jobPost.value.workStatus = JobPostWorkStatus.done.index;
      update([workInformation, buttonControls]);

      //Update job post list
      final jobPostController = Get.find<LandownerJobPostController>();
      final jobPosts = jobPostController.jobPosts;
      int index = jobPosts.indexWhere((job) => job.id == jobPost.value.id);
      if (index >= 0) {
        jobPosts[index] = jobPost.value;
      }

      CustomSnackbar.show(
        title: AppStrings.titleSuccess,
        message: AppMsg.MSG4038,
      );
    } catch (e) {
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  viewGardenDetails() async {
    //get garden by id
    try {
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
    } on CustomException catch (e) {
      if (e.message.contains('No content')) {
        CustomSnackbar.show(
          title: AppStrings.titleError,
          message: 'Vườn này đã bị xóa nên không thể xem chi tiết',
          backgroundColor: AppColors.errorColor,
        );
      }
    }
  }

  Future<void> getExpense() async {
    final tempExpense =
        await _attendanceRepository.getTotalExpense(jobPost.value.id);
    if (tempExpense != null) {
      totalPayingSalary.value = tempExpense;
    }
  }

  Future<bool?> getPaymentHistory() async {
    paymentHistories.clear();
    final int accountId = AuthCredentials.instance.user!.id!;
    final data = GetPaymentHistoryRequest(
      page: 1.toString(),
      pageSize: 20.toString(),
      jobPostId: jobPost.value.id.toString(),
      sortColumn: PaymentHistorySortColumn.createdDate,
      orderBy: SortOrder.descending,
    );

    final response = await _paymentHistoryRepository.getList(accountId, data);
    if (response == null || response.paymentHistories!.isEmpty) {
      return null;
    }

    double tempTotalPostingFee = 0;

    for (PaymentHistory payment in response.paymentHistories!) {
      paymentHistories.add(payment);
      tempTotalPostingFee += payment.balanceFluctuation?.abs() ?? 0;
    }

    totalPostingFee.value = tempTotalPostingFee;

    await getExpense();

    update([paymentHistoryInformation]);
    return true;
  }

  deleteJob() {
    CustomDialog.show(
        message: AppMsg.MSG4007,
        confirm: () async {
          final success = await _jobPostRepository.deleteJob(jobPost.value.id);

          //close dialog
          Get.back();

          if (!success) {
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
          final success = await _jobPostRepository.cancelJob(jobPost.value.id);

          //close dialog
          Get.back();

          if (!success) {
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

          //update balance
          _profile.calBalance();

          update([buttonControls]);

          CustomSnackbar.show(
            title: AppStrings.titleSuccess,
            message: AppMsg.MSG4010,
          );
        });
  }

  repostJobPost() {
    DateTime now = DateTime.now();
    DateTime publishDate = now.hour >= 16 && now.hour <= 23
        ? now.add(const Duration(days: 1))
        : now;
    final cloneJobPost = JobPost(
      id: 0,
      gardenId: jobPost.value.gardenId,
      title: jobPost.value.title,
      type: jobPost.value.type,
      jobStartDate: publishDate.add(const Duration(days: 1)),
      numOfPublishDay: 3,
      publishedBy: jobPost.value.publishedBy,
      publishedDate: publishDate,
      createdDate: jobPost.value.createdDate,
      status: jobPost.value.status,
      treeJobs: jobPost.value.treeJobs,
      address: jobPost.value.address,
      description: jobPost.value.description,
      payPerHourJob: jobPost.value.payPerHourJob,
      payPerTaskJob: jobPost.value.payPerTaskJob,
    );

    Get.toNamed(Routes.jobPostForm, arguments: {
      Arguments.action: Activities.create,
      Arguments.item: cloneJobPost,
      Arguments.tag: Get.arguments[Arguments.tag],
    });
  }

  extendExpiredDate() async {
    //get price config
    try {
      FeeData feeData;
      final result = await _feeDataService.getFeeConfig();
      if (result == null) throw Exception('Có lỗi xảy ra');
      feeData = result;

      ExtendExpiredDateDialog.show(
        jobPost.value.publishedDate
            .add(Duration(days: jobPost.value.numOfPublishDay - 1)),
        feeData,
        _profile,
        _extendExpiredDate,
      );
    } catch (e) {
      print('extendExpiredDate: ${e.toString()}');
    }
  }

  _extendExpiredDate(DateTime expandDate, int? usedPoint) async {
    try {
      final data = ExtendExpiredDateRequest(
        jobPostId: jobPost.value.id.toString(),
        newExpiredDate: expandDate,
        usedPoint: usedPoint?.toString(),
      );

      EasyLoading.show();
      final updatedJobPost = await _jobPostRepository.extendExpiredDate(data);
      if (updatedJobPost == null) throw Exception('Có lỗi xảy ra');

      //update job post details
      jobPost.value = updatedJobPost;

      //Update job post list
      final jobPosts = _jobPostController.jobPosts;
      int index = jobPosts.indexWhere((job) => job.id == updatedJobPost.id);
      if (index >= 0) {
        jobPosts[index] = updatedJobPost;
      }

      //update payment history
      await getPaymentHistory();

      //refresh balance
      await _profile.getUserInfo();

      update([postInformation, paymentHistoryInformation]);

      EasyLoading.dismiss();
      Get.back(); //close dialog

      CustomSnackbar.show(
        title: AppStrings.titleSuccess,
        message: 'Gia hạn thành công',
      );
    } catch (e) {
      EasyLoading.dismiss();
      //show error
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  updateDetails() {
    update([
      workInformation,
      workPlaceInformation,
      postInformation,
      paymentHistoryInformation,
      buttonControls,
    ]);
  }

  navigateToJobFarmerListScreen() {
    Get.toNamed(Routes.jobFarmerList,
        arguments: {Arguments.jobPostId: jobPost.value.id});
  }

  navigateToWorkHistory() {
    Get.toNamed(Routes.checkAttendance,
        arguments: {Arguments.item: jobPost.value});
  }
}
