import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
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
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
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

  Activities? get action => Get.arguments[Arguments.action];

  bool get _isFeatureNotDisplay =>
      jobPost.status == JobPostStatus.pending.index ||
      jobPost.status == JobPostStatus.outOfDate.index ||
      jobPost.status == JobPostStatus.rejected.index ||
      jobPost.status == JobPostStatus.cancel.index;

  bool get _isStartJob => jobPost.workStatus == JobPostWorkStatus.started.index;

  // bool get _isPosted => jobPost.status == JobPostStatus.posted.index;

  bool get _isApproved => jobPost.status == JobPostStatus.approved.index;

  bool get _isShortHanded => jobPost.status == JobPostStatus.shortHanded.index;

  bool get _isEnough => jobPost.status == JobPostStatus.enough.index;

  bool get _isRejected => jobPost.status == JobPostStatus.rejected.index;

  bool get _isExpired => jobPost.status == JobPostStatus.expired.index;

  bool get _isOutOfDate => jobPost.status == JobPostStatus.outOfDate.index;

  bool get _isPending => jobPost.status == JobPostStatus.pending.index;

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
              return const MyLoadingBuilder();
            }

            if (snapshot.hasError) {
              return const DetailsErrorBuilder();
            }

            return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 16.0),
              children: [
                _buildPostInfo(),
                _buildPostInformation(),
                _buildWorkInformation(),
                _buildWorkPlaceInformation(),
                _buildPaymentHistoryInformation(),
                if (!_isFeatureNotDisplay) ..._buildFeatures(),
                GetBuilder<LandownerJobPostDetailsController>(
                  id: 'ButtonControls',
                  tag: _myTag,
                  builder: (_) => Column(
                    children: _buildButtons(),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget _buildFindFarmerToggle() {
    // if (!_isApproved && !_isShortHanded && !_isEnough) return const SizedBox();
    return Row(
      children: [
        Text(
          '${AppStrings.labelPostStatus}:',
          style: Get.textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8.0),
        Obx(
          () => FlutterSwitch(
            value: controller.isFindingFarmer.value,
            width: Get.width * 0.3,
            height: Get.width * 0.08,
            valueFontSize: 13.0,
            activeTextFontWeight: FontWeight.normal,
            inactiveTextFontWeight: FontWeight.normal,
            onToggle: controller.onFindingFarmerToggle,
            activeColor: AppColors.successColor,
            activeText: 'Tuyển người',
            activeTextColor: AppColors.white,
            inactiveColor: AppColors.grey,
            inactiveText: 'Ngừng tuyển',
            inactiveTextColor: AppColors.white,
            showOnOff: true,
            padding: 8.0,
            toggleSize: 20.0,
          ),
        ),
      ],
    );
  }

  Widget _buildPostInfo() {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(
          top: 16.0,
          left: Get.width * 0.05,
          right: Get.width * 0.05,
        ),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 24.0,
          childAspectRatio: 11 / 5,
          children: [
            _buildFee(
              color: AppColors.errorColor,
              title: 'Chi phí đăng bài',
              data: Utils.vietnameseCurrencyFormat.format(
                controller.totalPostingFee.value,
              ),
            ),
            _buildFee(
              color: AppColors.warningColor,
              title: 'Chi phí trả lương',
              data: Utils.vietnameseCurrencyFormat.format(
                controller.totalPayingSalary.value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFee(
      {required Color color, required String title, required String data}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withOpacity(0.8)],
          tileMode: TileMode.mirror,
        ),
        borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Get.textTheme.bodyText2!.copyWith(
              color: AppColors.white,
            ),
          ),
          Text(
            data,
            style: Get.textTheme.bodyText1!.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildButtons() {
    List<Widget> widgets = [];
    if (action == null) {
      //add edit button
      if (_isPending) {
        final buttons = [
          const SizedBox(height: 8.0),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: FilledButton(
              title: AppStrings.titleEdit,
              onPressed: controller.navigateToUpdateForm,
            ),
          ),
        ];

        widgets.addAll(buttons);
      }

      //add finish job button
      if (_isStartJob) {
        final buttons = [
          const SizedBox(height: 8.0),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: FilledButton(
              title: AppStrings.titleFinishJob,
              onPressed: controller.finishJob,
            ),
          ),
        ];

        widgets.addAll(buttons);
      }

      //add extend job button
      // if (_isPosted) {
      //   final buttons = [
      //     const SizedBox(height: 8.0),
      //     FractionallySizedBox(
      //       widthFactor: 0.8,
      //       child: FilledButton(
      //         title: AppStrings.titleExtendPostEndDate,
      //         onPressed: controller.extendExpiredDate,
      //       ),
      //     ),
      //   ];
      //   widgets.addAll(buttons);
      // }

      if (jobPost.isPayPerHourJob &&
          (_isEnough || _isShortHanded || _isApproved)) {
        final buttons = [
          const SizedBox(height: 8.0),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: FilledButton(
              title: AppStrings.titleExtendMaxFarmer,
              onPressed: controller.updateMaxFarmer,
            ),
          ),
        ];
        widgets.addAll(buttons);
      }

      //add repost button
      if (_isExpired || _isOutOfDate) {
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

      //add delete button
      if (_isPending || _isOutOfDate || _isRejected) {
        final buttons = [
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

      //add cancel button
      if (_isApproved && !_isStartJob) {
        final buttons = [
          const SizedBox(height: 8.0),
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
        onTap: controller.navigateToJobFarmerListScreen,
      ),
      const SizedBox(height: 12.0),
      if (Utils.equalsIgnoreCase(jobPost.type, JobType.payPerHourJob.name))
        FeatureOption(
          icon: CustomIcons.work_history_outline,
          title: AppStrings.titleWorkHistory,
          borderRadius: CommonConstants.borderRadius,
          widthFactor: 0.9,
          onTap: controller.navigateToWorkHistory,
        ),
      // if (Utils.equalsIgnoreCase(jobPost.type, JobType.payPerTaskJob.name))
      //   FeatureOption(
      //     icon: CustomIcons.work_history_outline,
      //     title: AppStrings.titleExtendHistory,
      //     borderRadius: CommonConstants.borderRadius,
      //     widthFactor: 0.9,
      //     onTap: () {},
      //   ),
    ];
  }

  _buildPaymentHistoryInformation() {
    return ToggleInformation(
      tagName: controller.paymentHistoryInformation,
      title: AppStrings.titlePaymentInformation,
      isCustom: true,
      headerBorderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      child: GetBuilder<LandownerJobPostDetailsController>(
        id: controller.paymentHistoryInformation,
        tag: _myTag,
        builder: (_) => Column(
          children: _buildPaymentHistoryItem(controller.paymentHistories),
        ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                payment.message ?? '',
                style: Get.textTheme.headline6,
              ),
              const SizedBox(height: 4.0),
              PaymentDetailsInfo(
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
            ],
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

  Widget _buildPostStatus() {
    if (_isShortHanded || _isEnough) {
      return _buildFindFarmerToggle();
    }

    return CardStatusField(
      statusName: jobPost.jobPostStatusString,
      title: AppStrings.labelPostStatus,
      backgroundColor: jobPost.jobPostStatusColor,
    );
  }

  Widget _buildPostInformation() {
    DateTime? expiryDate = jobPost.pinStartDate == null
        ? null
        : jobPost.pinStartDate!.add(Duration(days: jobPost.totalPinDay! - 1));

    return ToggleInformation(
      tagName: controller.postInformation,
      title: AppStrings.titlePostInformation,
      headerBorderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      isOpen: true,
      isCustom: true,
      child: GetBuilder<LandownerJobPostDetailsController>(
        id: controller.postInformation,
        tag: _myTag,
        builder: (_) => ToggleContentPostInfo(
          title: AppStrings.titlePostInformation,
          createdDate: jobPost.createdDate,
          publishedDate: jobPost.publishedDate,
          // publishExpiryDate: jobPost.publishedDate
          //     .add(Duration(days: jobPost.numOfPublishDay - 1)),
          postStatus: _buildPostStatus(),
          approvedBy: jobPost.approvedName,
          approvedDate: jobPost.approvedDate,
          rejectedReason: jobPost.rejectedReason,
          postType: _buildPostType(),
          upgradedDate: jobPost.pinStartDate,
          upgradeExpiryDate: expiryDate,
        ),
      ),
    );
  }

  Widget _buildWorkPlaceInformation() {
    return ToggleInformation(
      tagName: controller.workPlaceInformation,
      title: AppStrings.titleWorkPlace,
      headerBorderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      child: GetBuilder<LandownerJobPostDetailsController>(
        id: controller.workPlaceInformation,
        tag: _myTag,
        builder: (_) => ToggleContentWorkPlaceInfo(
          gardenName: jobPost.gardenName ?? '',
          address: jobPost.address ?? '',
          onDetailsTap: controller.viewGardenDetails,
        ),
      ),
    );
  }

  Widget _buildWorkInformation() {
    return ToggleInformation(
      tagName: controller.workInformation,
      title: AppStrings.titleWorkInformation,
      isOpen: true,
      headerBorderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      child: GetBuilder<LandownerJobPostDetailsController>(
        id: controller.workInformation,
        tag: _myTag,
        builder: (_) => ToggleContentWorkInfo(
          workName: jobPost.title,
          workType: jobPost.workTypeName,
          jobStartDate: jobPost.jobStartDate,
          jobEndDate: jobPost.jobEndDate,
          treeTypes: jobPost.treeTypes,
          workPayType: jobPost.workType,
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
