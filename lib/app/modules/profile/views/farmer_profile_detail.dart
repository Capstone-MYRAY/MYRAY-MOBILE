import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/profile/controllers/farmer_profile_controller.dart';
import 'package:myray_mobile/app/modules/profile/widgets/personal_information_card.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/custom_circle_avatar.dart';

class FarmerProfileDetailView extends GetView<FarmerProfileController> {
  const FarmerProfileDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleViewProfile),
        elevation: 0.0,
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
      ),
      body: Obx(() {
        final currentUser = controller.user.value;
        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCircleAvatar(
                  url: currentUser.imageUrl,
                  radius: Get.width * 0.2,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  currentUser.fullName ?? AppStrings.nullFullName,
                  style: Get.textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  currentUser.roleName,
                  style: Get.textTheme.subtitle1!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                PersonalInformation(user: controller.user),
                const SizedBox(
                  height: 16.0,
                ),
                FilledButton(
                  title: AppStrings.titleEdit,
                  minWidth: CommonConstants.buttonWidthLarge,
                  minHeight: CommonConstants.buttonHeightSmall,
                  onPressed: () => Get.toNamed(
                    Routes.updateProfile,
                    arguments: {Arguments.item: currentUser},
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
