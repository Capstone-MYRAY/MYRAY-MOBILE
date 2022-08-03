import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history_models.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/applied_farmer_controller.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/extend_job_controller.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/wating_approve_tab_controller.dart';
import 'package:myray_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_controller.dart';
import 'package:myray_mobile/app/modules/payment_history/controllers/payment_history_controllers.dart';
import 'package:myray_mobile/app/modules/profile/controllers/landowner_profile_controller.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService _instance = NotificationService._();
  static NotificationService get instance => _instance;

  bool get _isFirst => Get.currentRoute == Routes.init;

  final _dashboardController = Get.find<DashboardController>();
  final _waitingApproveTabController = Get.find<WaitingApproveTabController>();

  updateData(String type, Map<String, dynamic> data) {
    if (Utils.equalsIgnoreCase(type, NotificationTypes.topUp.name)) {
      final profile = Get.find<LandownerProfileController>();
      profile.getUserInfo();
    } else if (Utils.equalsIgnoreCase(type, NotificationTypes.jobPost.name)) {
      final jobPostController = Get.find<LandownerJobPostController>();
      if (jobPostController.jobPosts.isNotEmpty) {
        jobPostController.onRefresh();
      }
    } else if (Utils.equalsIgnoreCase(
        type, NotificationTypes.appliedFarmer.name)) {
      final appliedFarmerController = Get.find<AppliedFarmerController>();
      appliedFarmerController.onRefresh(isProfileRefresh: false);
    } else if (Utils.equalsIgnoreCase(
        type, NotificationTypes.extendRequest.name)) {
      final extendJobController = Get.find<ExtendJobController>();
      extendJobController.onRefresh(isProfileRefresh: false);
    }
  }

  void Function()? serviceDelegate(String type, Map<String, dynamic> data) {
    //Top up account
    if (Utils.equalsIgnoreCase(type, NotificationTypes.topUp.name)) {
      return () => _navigateToPaymentHistoryDetails(data);
    }

    //Job post is approved or denied
    if (Utils.equalsIgnoreCase(type, NotificationTypes.jobPost.name)) {
      return () => _navigateToJobPostDetails(data);
    }

    //Farmer requests to apply to the job
    if (Utils.equalsIgnoreCase(type, NotificationTypes.appliedFarmer.name)) {
      return _navigateToAppliedFarmer;
    }

    //Farmer requests to extend job
    if (Utils.equalsIgnoreCase(type, NotificationTypes.extendRequest.name)) {
      return _navigateToExtendJob;
    }

    return null;
  }

  _popUntilHome() {
    if (!_isFirst) {
      Get.until((route) => route.isFirst);
    }
  }

  _navigateToPaymentHistoryDetails(Map<String, dynamic> data) async {
    try {
      Get.toNamed(Routes.paymentHistoryHome);

      //TODO: wait for Lâm to reduce delay time
      await Future.delayed(const Duration(milliseconds: 500));

      final controller = Get.find<PaymentHistoryHomeController>();

      if (data['paymentHistoryId'] == null) {
        throw CustomException('Không có payment history id!');
      }

      int id = int.parse(data['paymentHistoryId']);

      PaymentHistory? payment = controller.findById(id);
      EasyLoading.show();
      payment ??= await controller.getById(id);
      EasyLoading.dismiss();

      if (payment == null) {
        throw CustomException('payment null');
      }

      _popUntilHome();

      Get.toNamed(
        Routes.paymentHistoryDetails,
        arguments: {
          Arguments.tag: payment.id.toString(),
          Arguments.item: payment,
        },
      );

      //change tab
      _dashboardController.changeTabIndex(LandownerTabs.profile.index);
    } catch (e) {
      print(e.toString());
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  _navigateToJobPostDetails(Map<String, dynamic> data) async {
    try {
      final controller = Get.find<LandownerJobPostController>();

      if (data['jobPostId'] == null) {
        throw CustomException('Không có job post id!');
      }

      int id = int.parse(data['jobPostId']);

      JobPost? jobPost = controller.findById(id);
      EasyLoading.show();
      jobPost ??= await controller.getById(id);
      EasyLoading.dismiss();

      if (jobPost == null) {
        throw CustomException('Job post null');
      }

      _popUntilHome();

      Get.toNamed(
        Routes.landownerJobPostDetails,
        arguments: {
          Arguments.tag: jobPost.id.toString(),
          Arguments.item: jobPost,
        },
      );

      //change tab
      _dashboardController.changeTabIndex(LandownerTabs.jobPost.index);
    } catch (e) {
      print(e.toString());
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  _navigateToAppliedFarmer() {
    _dashboardController.changeTabIndex(LandownerTabs.appliedFarmer.index);
    _waitingApproveTabController.tabController
        .animateTo(WaitingApproveTabs.appliedFarmer.index);
    _popUntilHome();
  }

  _navigateToExtendJob() {
    _dashboardController.changeTabIndex(LandownerTabs.appliedFarmer.index);
    _waitingApproveTabController.tabController
        .animateTo(WaitingApproveTabs.extendRequest.index);
    _popUntilHome();
  }
}
