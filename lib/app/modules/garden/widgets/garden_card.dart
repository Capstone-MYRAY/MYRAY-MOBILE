import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/filled_button.dart';

class GardenCard extends StatelessWidget {
  const GardenCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 60,
                    maxHeight: 60,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        CommonConstants.borderRadius,
                      ),
                    ),
                    child: Image.asset(AppAssets.tempAvatar),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CardField(
                        icon: CustomIcons.sprout_outline,
                        title: 'Tên vườn',
                        data: 'Long An Bình Phước nè - 100000000',
                      ),
                      CardField(
                        icon: CustomIcons.map_marker_outline,
                        title: 'Khu vực',
                        data: 'Long An',
                      ),
                      CardField(
                        icon: CustomIcons.mountain,
                        title: 'Diện tích',
                        data: '1000ha',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  minWidth: CommonConstants.buttonWidthSmall,
                  title: AppStrings.titleDelete,
                  onPressed: () {},
                  color: AppColors.errorColor,
                ),
                const SizedBox(width: 16.0),
                FilledButton(
                  minWidth: CommonConstants.buttonWidthSmall,
                  title: AppStrings.titleDetails,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
