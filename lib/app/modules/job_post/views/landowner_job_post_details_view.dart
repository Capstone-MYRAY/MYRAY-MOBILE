import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_hour_job/pay_per_hour_job.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_task_job/pay_per_task_job.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_details_controller.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/landowner_job_post_details/landowner_job_post_details.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_status_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/feature_option.dart';

class LandownerJobPostDetailsView
    extends GetView<LandownerJobPostDetailsController> {
  const LandownerJobPostDetailsView({Key? key}) : super(key: key);

  @override
  String get tag => Get.arguments[Arguments.tag];

  JobPost get jobPost => controller.jobPost.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleJobPostDetail),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 16.0),
        children: [
          _buildWorkInformation(),
          _buildWorkPlaceInformation(),
          _buildPostInformation(),
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
            icon: CustomIcons.feedback_outline,
            title: AppStrings.titleFeedbackList,
            borderRadius: CommonConstants.borderRadius,
            widthFactor: 0.9,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPostInformation() {
    return ToggleInformation(
      tagName: 'PostInformation',
      title: AppStrings.titlePostInformation,
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
        //TODO: upgrade information (wait for backend)
      ),
    );
  }

  Widget _buildWorkPlaceInformation() {
    return ToggleInformation(
      tagName: 'WorkPlaceInformation',
      title: AppStrings.titleWorkPlace,
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
      child: ToggleContentWorkInfo(
        workName: jobPost.title,
        jobStartDate: jobPost.jobStartDate,
        jobEndDate: jobPost.jobEndDate,
        treeTypes: jobPost.treeTypes,
        workType: jobPost.workType,
        description: jobPost.description,
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
      String workingTime = '${hourJob.startTime} - ${hourJob.finishTime}';

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
