import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/profile/controllers/landowner_profile_controller.dart';
import 'package:myray_mobile/app/modules/profile/widgets/landowner_avatar.dart';
import 'package:myray_mobile/app/modules/profile/widgets/landowner_feature_options.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/landowner_appbar.dart';

class LandownerProfileView extends GetView<LandownerProfileController> {
  const LandownerProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LandownerAppbar(
        title: Text(
          AppStrings.profile,
          textScaleFactor: 1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => LandownerAvatar(
                fullName: controller.user.value.fullName ?? '',
                avatar: controller.user.value.imageUrl,
                onButtonClick: () {
                  Get.toNamed(Routes.landownerProfile);
                },
              ),
            ),
            const SizedBox(height: 32),
            const LandownerFeatureOptions(),
          ],
        ),
      ),
    );
  }
}
