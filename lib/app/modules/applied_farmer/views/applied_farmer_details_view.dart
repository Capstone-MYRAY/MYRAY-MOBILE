import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer_models.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/applied_farmer_details_controller.dart';
import 'package:myray_mobile/app/modules/applied_farmer/widgets/job_post_info.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/builders/details_error_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';
import 'package:myray_mobile/app/shared/widgets/farmer_details/farmer_details.dart';
import 'package:myray_mobile/app/shared/widgets/farmer_details/farmer_details_appbar.dart';

class AppliedFarmerDetailsView extends GetView<AppliedFarmerDetailsController> {
  const AppliedFarmerDetailsView({Key? key}) : super(key: key);

  @override
  String get tag => Get.arguments[Arguments.tag];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FarmerDetailsAppbar(
        title: controller.appliedFarmer.value.userInfo.fullName ?? '',
      ),
      body: FutureBuilder(
        future: controller.initData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyLoadingBuilder();
          }

          if (snapshot.hasError) {
            return const DetailsErrorBuilder();
          }

          final user = controller.appliedFarmer.value.userInfo;
          return SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => FarmerDetails(
                      role: user.roleName,
                      user: Rx(user),
                      avatar: user.imageUrl,
                      rating: user.rating,
                      isBookmarked: controller.isBookmarked.value,
                      onFavoriteToggle: () => controller.onToggleBookmark(),
                      navigateToChatScreen: controller.navigateToChatScreen,
                      onRatingDetails: controller.getFeedbackList,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Obx(
                    () => JobPostInfo(
                      title: controller.appliedFarmer.value.jobPost.title,
                      gardenName:
                          controller.appliedFarmer.value.jobPost.gardenName ??
                              '',
                      workType:
                          controller.appliedFarmer.value.jobPost.workTypeName,
                      workPayType:
                          controller.appliedFarmer.value.jobPost.workPayType,
                      approvedFarmer: controller.totalApprovedFarmer.value,
                      maxFarmer: controller
                          .appliedFarmer.value.jobPost.payPerHourJob?.maxFarmer,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Obx(
                    () => _buildBottom(
                      controller.appliedFarmer.value,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildBottom(AppliedFarmer appliedFarmer) {
    bool isPending = appliedFarmer.status == AppliedFarmerStatus.pending.index;

    bool isApproved =
        appliedFarmer.status == AppliedFarmerStatus.approved.index;

    if (isPending) {
      return FractionallySizedBox(
        widthFactor: 0.7,
        child: Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: controller.reject,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                ),
                title: AppStrings.titleRefuse,
                color: AppColors.errorColor,
              ),
            ),
            if (appliedFarmer.jobPost.status ==
                JobPostStatus.shortHanded.index) ...[
              const SizedBox(width: 16.0),
              Expanded(
                child: FilledButton(
                  title: AppStrings.titleHire,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  onPressed: controller.approve,
                ),
              ),
            ],
          ],
        ),
      );
    }

    final color = isApproved ? AppColors.primaryColor : AppColors.errorColor;
    final statusString =
        appliedFarmer.status == AppliedFarmerStatus.approved.index
            ? 'Đã nhận'
            : 'Đã từ chối';

    return FractionallySizedBox(
      widthFactor: 0.4,
      child: StatusChip(
        statusName: statusString,
        backgroundColor: Colors.transparent,
        foregroundColor: color,
        border: Border.all(color: color),
        borderRadius: 10.0,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        fontSize: 14.0 * Get.textScaleFactor,
      ),
    );
  }
}
