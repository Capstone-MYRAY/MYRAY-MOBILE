import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/roles.dart';
import 'package:myray_mobile/app/modules/auth/controllers/signup_controller.dart';
import 'package:myray_mobile/app/modules/auth/widgets/selection_card.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class ChooseRoleView extends GetView<SignupController> {
  const ChooseRoleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.countrySide,
                  width: Get.width * 0.6,
                ),
                const SizedBox(height: 16.0),
                Text(
                  AppStrings.titleChooseRole,
                  style: Get.textTheme.headline5,
                ),
                const SizedBox(height: 8.0),
                Text(
                  AppStrings.captionChooseRole,
                  style: Get.textTheme.caption,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: Get.width * 0.8,
                  child: Column(
                    children: [
                      IntrinsicHeight(
                        child: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SelectionCard(
                                imagePath: AppAssets.farmer,
                                title: AppStrings.farmer,
                                caption: AppStrings.captionFarmer,
                                onTap: controller.onSelectFarmer,
                                isSelected: controller.selectedRole.value ==
                                    Roles.farmer,
                              ),
                              const SizedBox(width: 12.0),
                              SelectionCard(
                                imagePath: AppAssets.landowner,
                                title: AppStrings.landowner,
                                caption: AppStrings.captionLandowner,
                                onTap: controller.onSelectLandowner,
                                isSelected: controller.selectedRole.value ==
                                    Roles.landowner,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Obx(
                        () => ElevatedButton(
                          onPressed: controller.selectedRole.value == Roles.none
                              ? null
                              : controller.navigateToSignupScreen,
                          child: const Text(AppStrings.titleContinue),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
