import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/profile/controllers/landowner_profile_controller.dart';
import 'package:myray_mobile/app/modules/profile/widgets/personal_information_card.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/custom_circle_avatar.dart';

class LandownerProfileDetailsView extends GetView<LandownerProfileController> {
  const LandownerProfileDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        elevation: 0.0,
        title: const Text(AppStrings.profile),
      ),
      body: Obx(() {
        final user = controller.user.value;
        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCircleAvatar(
                  url: user.imageUrl,
                  radius: Get.width * 0.2,
                ),
                const SizedBox(height: 16.0),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Get.width * 0.9,
                  ),
                  child: Text(
                    user.fullName ?? '',
                    style: Get.textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  user.roleName,
                  style: Get.textTheme.subtitle1!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 16.0),
                PersonalInformation(user: controller.user),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: Get.width * 0.8,
                  child: FilledButton(
                    title: AppStrings.titleEdit,
                    onPressed: () => Get.toNamed(
                      Routes.updateProfile,
                      arguments: {Arguments.item: user},
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
