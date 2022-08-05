import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';

class GardenCard extends StatelessWidget {
  final String thumbnail;
  final String gardenName;
  final String address;
  final double landArea;
  final void Function()? onDeleteTap;
  final void Function()? onDetailsTap;

  const GardenCard({
    Key? key,
    required this.thumbnail,
    required this.gardenName,
    required this.address,
    required this.landArea,
    this.onDeleteTap,
    this.onDetailsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      CommonConstants.borderRadius,
                    ),
                  ),
                  child: Image.network(
                    thumbnail,
                    fit: BoxFit.fill,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardField(
                      icon: CustomIcons.sprout_outline,
                      title: 'Tên vườn',
                      data: gardenName,
                    ),
                    const SizedBox(height: 4),
                    CardField(
                      icon: CustomIcons.map_marker_outline,
                      title: 'Địa chỉ',
                      data: address,
                    ),
                    const SizedBox(height: 4),
                    CardField(
                      icon: CustomIcons.mountain,
                      title: 'Diện tích',
                      data: '$landArea ha',
                      isCenter: true,
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
                onPressed: onDeleteTap,
                color: AppColors.errorColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 4.0,
                ),
              ),
              const SizedBox(width: 16.0),
              FilledButton(
                minWidth: CommonConstants.buttonWidthSmall,
                title: AppStrings.titleDetails,
                onPressed: onDetailsTap,
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 4.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
