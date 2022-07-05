import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';

class ToggleContentWorkPlaceInfo extends StatelessWidget {
  final String gardenName;
  final String address;
  final void Function() onDetailsTap;

  const ToggleContentWorkPlaceInfo({
    Key? key,
    required this.gardenName,
    required this.address,
    required this.onDetailsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardField(
          icon: CustomIcons.sprout_outline,
          title: AppStrings.labelGardenName,
          data: gardenName,
        ),
        const SizedBox(height: 8.0),
        CardField(
          icon: CustomIcons.map_marker_outline,
          title: AppStrings.labelAddress,
          data: address,
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: CommonConstants.buttonHeightSmall,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
              splashFactory: NoSplash.splashFactory,
            ),
            child: Text(AppStrings.titleDetails.toUpperCase()),
            onPressed: onDetailsTap,
          ),
        ),
      ],
    );
  }
}
