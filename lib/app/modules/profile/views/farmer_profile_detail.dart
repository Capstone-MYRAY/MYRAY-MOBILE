import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/profile/controllers/farmer_profile_controller.dart';
import 'package:myray_mobile/app/modules/profile/widgets/personal_information_card.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';

class FarmerProfileDetailView extends StatelessWidget {
  const FarmerProfileDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleViewProfile),
        elevation: 0.0,
        backgroundColor: AppColors.white,
        centerTitle: true,
      ),
      body: GetBuilder<FarmerProfileController>(builder: (controller) {
        final _currentUser = controller.user.value;
        final _avatar = _currentUser.imageUrl == null
            ? const AssetImage(AppAssets.tempAvatar) as ImageProvider
            : NetworkImage(_currentUser.imageUrl!);
        final _role = _currentUser.roleId == CommonConstants.landownerRoleId
            ? AppStrings.landowner
            : AppStrings.farmer;
        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: Get.width * 0.2,
                backgroundColor: Colors.transparent,
                backgroundImage: _avatar,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(_currentUser.fullName ?? AppStrings.nullFullName),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                _role,
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
                  onPressed: () {}),
              const SizedBox(
                height: 20.0,
              ),
            ],
          )),
        );
      }),
    );
  }
}
