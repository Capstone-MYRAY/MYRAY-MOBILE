import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/custom_outline_button.dart';
import 'package:myray_mobile/app/shared/widgets/filled_button.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final void Function()? onPressedOutlineButton;
  final void Function()? onPressedFilledButton;
  final bool? isDisableOutlineButton;
  final bool? isDisableFilledButton;
  const CustomBottomNavigationBar({
    Key? key,
    this.onPressedOutlineButton,
    this.onPressedFilledButton,
    this.isDisableOutlineButton = false,
    this.isDisableFilledButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomOutlineButton(
            icon: CustomIcons.chat,
            text: AppStrings.messageButton,
            onPressed: onPressedOutlineButton,
          ),
          const SizedBox(
            width: 15,
          ),
          Flexible(
            child: FilledButton(
              title: AppStrings.applyButton,
              onPressed: onPressedFilledButton,
            ),
          ),
        ],
      ),
    );
  }
}
