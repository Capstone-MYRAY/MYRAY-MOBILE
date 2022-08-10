import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/profile/controllers/farmer_profile_controller.dart';
import 'package:myray_mobile/app/modules/profile/widgets/farmer_avatar.dart';
import 'package:myray_mobile/app/modules/profile/widgets/farmer_feature_option.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';

class FarmerProfileView extends GetView<FarmerProfileController> {
  const FarmerProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profile, textScaleFactor: 1,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => FarmerAvatar(
                avatar: controller.user.value.imageUrl,
                fullName: controller.user.value.fullName ?? '',
                point: controller.user.value.point,
                onButtonClick: controller.navigateToDetailpage,
              ),
            ),
            const SizedBox(height: 32),
            FarmerFeatureOptions(
              bookmark: controller.navigateToBookmarkPage,
              attendance: controller.navigateToAttendancePage,
              history: controller.navigateToHistoryJob,
              password: controller.navigateToChangePassword,
              appliedJob: controller.navigateToHistoryAppliedJob
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
