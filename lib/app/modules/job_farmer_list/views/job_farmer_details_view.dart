import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/modules/job_farmer_list/controllers/controllers.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/builders/details_error_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field_no_icon.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/farmer_details/farmer_details.dart';
import 'package:myray_mobile/app/shared/widgets/farmer_details/farmer_details_appbar.dart';
import 'package:myray_mobile/app/shared/widgets/rating_star.dart';

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
                    if (controller.feedback.value != null) _buildFeedback(),
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
                                onPressed: () {},
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
    if (feedback == null) return;
    DateTime? endDate = controller.appliedFarmer.value.jobPost.jobEndDate;
    bool canUpdate = endDate == null ||
        DateTime.now().isBefore(endDate
            .add(const Duration(days: CommonConstants.dayCanEditFeedback)));
    return MyCard(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 32.0,
        right: 32,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Ngày tạo: ${Utils.formatddMMyyyy(feedback.createdDate)}',
              style: Get.textTheme.caption!.copyWith(
                fontSize: 12 * Get.textScaleFactor,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Thông tin đánh giá',
              style: Get.textTheme.headline6,
            ),
          ),
          const SizedBox(height: 8.0),
          RatingStar(
            rating: feedback.numStar.toDouble(),
            itemSize: 24.0,
          ),
          const SizedBox(height: 8.0),
          CardField(
            title: 'Chi tiết đánh giá',
            icon: CustomIcons.content_paste,
            data: feedback.content.isEmpty ? 'N/A' : feedback.content,
          ),
          if (canUpdate)
            TextButton(
              onPressed: controller.onFeedback,
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: const Text(AppStrings.titleEdit),
            ),
        ],
      ),
    );
  }
}
