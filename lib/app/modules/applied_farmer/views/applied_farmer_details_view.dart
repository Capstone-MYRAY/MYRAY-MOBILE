import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer_models.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/applied_farmer_details_controller.dart';
import 'package:myray_mobile/app/modules/profile/widgets/personal_information_card.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';
import 'package:myray_mobile/app/shared/widgets/rating_star.dart';

class AppliedFarmerDetailsView extends StatelessWidget {
  const AppliedFarmerDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0.0,
      ),
      body: GetBuilder<AppliedFarmerDetailsController>(
        tag: Get.arguments[Arguments.tag],
        builder: (controller) {
          final _user = controller.appliedFarmer.value.userInfo;
          final _avatar = _user.imageUrl == null
              ? const AssetImage(AppAssets.tempAvatar) as ImageProvider
              : NetworkImage(_user.imageUrl!);
          return SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: Get.width * 0.2,
                    backgroundColor: Colors.transparent,
                    backgroundImage: _avatar,
                  ),
                  const SizedBox(height: 16.0),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: Get.width * 0.9,
                    ),
                    child: Text(
                      _user.fullName ?? '',
                      style: Get.textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    _user.roleName,
                    style: Get.textTheme.subtitle1!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 16 * Get.textScaleFactor,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  RatingStar(
                    itemSize: 28.0,
                    rating: _user.rating ?? 0.0,
                  ),
                  const SizedBox(height: 16.0),
                  FractionallySizedBox(
                    widthFactor: 0.3,
                    child: ElevatedButton.icon(
                      icon: const Icon(CustomIcons.chat, size: 24.0),
                      label: const Text(AppStrings.messageButton),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  PersonalInformation(user: Rx(_user)),
                  const SizedBox(height: 16.0),
                  _buildBottom(
                    controller.appliedFarmer.value,
                    controller,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildBottom(
      AppliedFarmer appliedFarmer, AppliedFarmerDetailsController controller) {
    bool isPending = appliedFarmer.status == AppliedFarmerStatus.pending.index;

    bool isApproved =
        appliedFarmer.status == AppliedFarmerStatus.approved.index;

    if (isPending) {
      return FractionallySizedBox(
        widthFactor: 0.7,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                child: const Text(AppStrings.titleRefuse),
                onPressed: controller.reject,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: FilledButton(
                title: AppStrings.titleHire,
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                onPressed: controller.approve,
              ),
            ),
          ],
        ),
      );
    }

    final color = isApproved ? AppColors.primaryColor : AppColors.errorColor;

    return FractionallySizedBox(
      widthFactor: 0.4,
      child: StatusChip(
        statusName: appliedFarmer.statusString,
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
