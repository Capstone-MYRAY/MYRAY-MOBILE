import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
import 'package:myray_mobile/app/modules/job_farmer_list/controllers/controllers.dart';
import 'package:myray_mobile/app/modules/job_farmer_list/widgets/feedback_farmer_card.dart';
import 'package:myray_mobile/app/modules/job_farmer_list/widgets/report_farmer_card.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/builders/details_error_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/farmer_details/farmer_details.dart';
import 'package:myray_mobile/app/shared/widgets/farmer_details/farmer_details_appbar.dart';

class JobFarmerDetailsView extends GetView<JobFarmerDetailsController> {
  const JobFarmerDetailsView({Key? key}) : super(key: key);

  @override
  String get tag => Get.arguments[Arguments.tag];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FarmerDetailsAppbar(
        title: controller.appliedFarmer.value.userInfo.fullName ?? '',
      ),
      body: FutureBuilder(
        future: controller.init(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBuilder();
          }

          if (snapshot.hasError) {
            return const DetailsErrorBuilder();
          }

          final user = controller.appliedFarmer.value.userInfo;
          return Obx(
            () => SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FarmerDetails(
                      role: user.roleName,
                      user: Rx(user),
                      avatar: user.imageUrl,
                      rating: user.rating,
                      statusName: controller.appliedFarmer.value.statusString,
                      statusColor: controller.appliedFarmer.value.statusColor,
                      isBookmarked: controller.isBookmarked.value,
                      onFavoriteToggle: () => controller.onToggleBookmark(),
                      navigateToChatScreen: controller.navigateToChatScreen,
                    ),
                    _buildFeedback(),
                    _buildReport(),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (controller.report.value == null) ...[
                          SizedBox(
                            width: Get.width * 0.35,
                            child: SizedBox(
                              child: FilledButton(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                title: AppStrings.titleReport,
                                color: AppColors.errorColor,
                                onPressed: controller.onReport,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                        ],
                        if (controller.feedback.value == null)
                          SizedBox(
                            width: Get.width * 0.35,
                            child: FilledButton(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              title: AppStrings.titleFeedback,
                              onPressed: controller.onFeedback,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildFeedback() {
    FeedBack? feedback = controller.feedback.value;
    if (feedback == null) return const SizedBox();
    DateTime? endDate = controller.appliedFarmer.value.jobPost.jobEndDate;
    bool canUpdate = endDate == null ||
        DateTime.now().isBefore(endDate
            .add(const Duration(days: CommonConstants.dayCanEditFeedback)));
    return FeedbackFarmerCard(
      createdDate: feedback.createdDate,
      rating: feedback.numStar.toDouble(),
      content: feedback.content,
      canUpdate: canUpdate,
      onEditPressed: controller.onFeedback,
    );
  }

  _buildReport() {
    Report? report = controller.report.value;

    if (report == null) return const SizedBox();
    return ReportFarmerCard(
      createdDate: report.createdDate,
      content: report.content,
      statusName: report.statusString,
      statusColor: report.statusColor,
      resolvedContent: report.resolveContent,
      resolvedDate: report.resolvedDate,
      resolvedName: report.resolvedName,
    );
  }
}
