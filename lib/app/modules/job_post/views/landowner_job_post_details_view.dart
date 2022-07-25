import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_hour_job/pay_per_hour_job.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_task_job/pay_per_task_job.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history_models.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_details_controller.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/landowner_job_post_details/landowner_job_post_details.dart';
import 'package:myray_mobile/app/modules/payment_history/widgets/payment_details_info.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/hex_color_extension.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/builders/details_error_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_status_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/feature_option.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';

class LandownerJobPostDetailsView
    extends GetView<LandownerJobPostDetailsController> {
  final String _myTag = Get.arguments[Arguments.tag];
  LandownerJobPostDetailsView({Key? key}) : super(key: key);

  @override
  String get tag => _myTag;

  JobPost get jobPost => controller.jobPost.value;

  Activities? get action => Get.arguments?[Arguments.action];

  bool get _isFeatureNotDisplay =>
      jobPost.status == JobPostStatus.pending.index ||
      jobPost.status == JobPostStatus.outOfDate.index ||
      jobPost.status == JobPostStatus.rejected.index;

  bool get _isStartJob => jobPost.workStatus == JobPostWorkStatus.started.index;

  bool get _isPosted => jobPost.status == JobPostStatus.posted.index;

  bool get _isApproved => jobPost.status == JobPostStatus.approved.index;

  bool get _isRepost => jobPost.status == JobPostStatus.expired.index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleJobPostDetail),
      ),
      body: FutureBuilder(
          future: controller.getPaymentHistory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingBuilder();
            }

            if (snapshot.hasError || snapshot.data == null) {
              return const DetailsErrorBuilder();
            }

            return Obx(
              () => ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 16.0),
                children: [
                  _buildWorkInformation(),
                  _buildWorkPlaceInformation(),
                  _buildPostInformation(),
                  _buildPaymentHistoryInformation(),
                  if (!_isFeatureNotDisplay) ..._buildFeatures(),
                  const SizedBox(height: 16.0),
                  ..._buildButtons(),
                ],
              ),
            );
          }),
    );
  }

  List<Widget> _buildButtons() {
    List<Widget> widgets = [];
    if (action == null) {
      if (jobPost.status == JobPostStatus.pending.index) {
        final buttons = [
          FractionallySizedBox(
            widthFactor: 0.8,
            child: FilledButton(
              title: AppStrings.titleEdit,
              onPressed: controller.navigateToUpdateForm,
            ),
          ),
          const SizedBox(height: 8.0),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: FilledButton(
              title: AppStrings.titleDelete,
              onPressed: controller.deleteJob,
              color: AppColors.errorColor,
            ),
          ),
        ];
        widgets.addAll(buttons);
      }

      if (_isApproved && !_isStartJob) {
        final buttons = [
          FractionallySizedBox(
            widthFactor: 0.8,
            child: FilledButton(
              title: AppStrings.cancel,
              color: AppColors.errorColor,
              onPressed: controller.cancelJob,
            ),
          ),
        ];

        widgets.addAll(buttons);
      }

      if (_isPosted) {
        final buttons = [
          const SizedBox(height: 8.0),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: FilledButton(
              title: AppStrings.titleExtendPostEndDate,
              onPressed: controller.extendExpiredDate,
            ),
          ),
        ];
        widgets.addAll(buttons);
      }

      if (_isRepost) {
        final button = [
          const SizedBox(height: 8.0),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: FilledButton(
              title: AppStrings.titleRepost,
              onPressed: controller.repostJobPost,
            ),
          ),
        ];
        widgets.addAll(button);
      }
    }

    return widgets;
  }

  List<Widget> _buildFeatures() {
    return [
      const SizedBox(height: 16.0),
      FeatureOption(
        icon: CustomIcons.account_cowboy_hat_outline,
        title: AppStrings.titleFarmerList,
        borderRadius: CommonConstants.borderRadius,
        widthFactor: 0.9,
        onTap: () {},
      ),
      const SizedBox(height: 12.0),
      FeatureOption(
        icon: CustomIcons.work_history_outline,
        title: AppStrings.titleWorkHistory,
        borderRadius: CommonConstants.borderRadius,
        widthFactor: 0.9,
        onTap: () {},
      ),
    ];
  }

  _buildPaymentHistoryInformation() {
    return ToggleInformation(
      tagName: 'PaymentInformation',
      title: AppStrings.titlePaymentInformation,
      isCustom: true,
      headerBorderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      child: Column(
        children: _buildPaymentHistoryItem(controller.paymentHistories),
      ),
    );
  }

  List<Widget> _buildPaymentHistoryItem(List<PaymentHistory> list) {
    List<Widget> items = [];
    for (int i = 0; i < list.length; i++) {
      PaymentHistory payment = list[i];
      bool hasBorder = i < list.length - 1;
      items.add(
        MyCard(
          onTap: () {
            Get.toNamed(Routes.paymentHistoryDetails, arguments: {
              Arguments.tag: payment.id.toString(),
              Arguments.item: payment,
              Arguments.action: Activities.view,
            });
          },
          margin: const EdgeInsets.all(0.0),
          child: PaymentDetailsInfo(
            postingFee: payment.jobPostPrice ?? 0,
            numOfPostingDay: payment.numOfPublishDay ?? 0,
            pointFee: payment.pointPrice ?? 0,
            usedPoint: payment.usedPoint ?? 0,
            earnedPoint: payment.earnedPoint ?? 0,
            total: payment.balanceFluctuation ?? 0,
            paymentId: payment.id.toString(),
            numOfUpgradingDay: payment.totalPinDay ?? 0,
            upgradingFee: payment.postTypePrice ?? 0,
          ),
        ),
      );
      if (hasBorder) items.add(const SizedBox(height: 8.0));
    }
    return items;
  }

  CardStatusField? _buildPostType() {
    if (jobPost.postTypeId != null) {
      return CardStatusField(
        statusName: jobPost.postTypeName ?? '',
        title: 'Gói nâng cấp',
        backgroundColor: jobPost.backgroundColor != null
            ? HexColor.fromHex(jobPost.backgroundColor!)
            : null,
        foregroundColor: jobPost.foregroundColor != null
            ? HexColor.fromHex(jobPost.foregroundColor!)
            : null,
      );
    }

    return null;
  }

  Widget _buildPostInformation() {
    DateTime? expiryDate = jobPost.pinStartDate == null
        ? null
        : jobPost.pinStartDate!.add(Duration(days: jobPost.totalPinDay! - 1));

    return ToggleInformation(
      tagName: 'PostInformation',
      title: AppStrings.titlePostInformation,
      headerBorderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      child: ToggleContentPostInfo(
        createdDate: jobPost.createdDate,
        publishedDate: jobPost.publishedDate,
        publishExpiryDate: jobPost.publishedDate
            .add(Duration(days: jobPost.numOfPublishDay - 1)),
        postStatus: CardStatusField(
          statusName: jobPost.jobPostStatusString,
          title: AppStrings.labelPostStatus,
          backgroundColor: jobPost.jobPostStatusColor,
        ),
        approvedBy: jobPost.approvedName,
        approvedDate: jobPost.approvedDate,
        rejectedReason: jobPost.rejectedReason,
        postType: _buildPostType(),
        upgradedDate: jobPost.pinStartDate,
        upgradeExpiryDate: expiryDate,
      ),
    );
  }

  Widget _buildWorkPlaceInformation() {
    return ToggleInformation(
      tagName: 'WorkPlaceInformation',
      title: AppStrings.titleWorkPlace,
      headerBorderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      child: ToggleContentWorkPlaceInfo(
        gardenName: jobPost.gardenName ?? '',
        address: jobPost.address ?? '',
        onDetailsTap: controller.viewGardenDetails,
      ),
    );
  }

  Widget _buildWorkInformation() {
    return ToggleInformation(
      tagName: 'WorkInformation',
      title: AppStrings.titleWorkInformation,
      isOpen: true,
      headerBorderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      child: ToggleContentWorkInfo(
        workName: jobPost.title,
        jobStartDate: jobPost.jobStartDate,
        jobEndDate: jobPost.jobEndDate,
        treeTypes: jobPost.treeTypes,
        workType: jobPost.workType,
        description: jobPost.description?.contains('\n') != null
            ? '\n${jobPost.description}'
            : jobPost.description,
        workStatus: CardStatusField(
          statusName: jobPost.jobPostWorkStatusString,
          title: AppStrings.labelWorkStatus,
          backgroundColor: jobPost.jobPostWorkStatusColor,
        ),
        workContent: _buildWorkContent(),
      ),
    );
  }

  _buildWorkContent() {
    if (Utils.equalsUtf8String(
        controller.jobPost.value.workType, AppStrings.payPerHour)) {
      final PayPerHourJob hourJob = jobPost.payPerHourJob!;
      String estimateFarmer = hourJob.minFarmer == hourJob.maxFarmer
          ? '${hourJob.maxFarmer} người'
          : '${hourJob.minFarmer} - ${hourJob.maxFarmer} người';
      String workingTime =
          '${Utils.getHHmm(hourJob.startTime)} - ${Utils.getHHmm(hourJob.finishTime)}';

      return PayByHourWidget(
          estimateFarmer: estimateFarmer,
          estimateWork: hourJob.estimatedTotalTask.toString(),
          salary: hourJob.salary,
          workingTime: workingTime);
    }

    final PayPerTaskJob taskJob = jobPost.payPerTaskJob!;
    return PayByTaskWidget(
      salary: taskJob.salary,
      toolAvailable: taskJob.isFarmToolsAvaiable!,
    );
  }
}
