import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_outline_button.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final void Function()? onPressedOutlineButton;
  final void Function()? onPressedFilledButton;
  final bool? isDisableOutlineButton;
  final bool? isDisableFilledButton;
  final bool? isChangedState;
  final bool? isExpired;
  final int status;
  var titleButton = AppStrings.shortApplyButton;
  CustomBottomNavigationBar({
    Key? key,
    this.onPressedOutlineButton,
    this.onPressedFilledButton,
    this.isDisableOutlineButton = false,
    this.isDisableFilledButton = false,
    this.isChangedState = false,
    this.isExpired = false,
    this.status = 8
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getStatus(status);
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
              // title: isExpired! ? 'Hết hạn' : AppStrings.shortApplyButton,
              title: titleButton,
              onPressed: (isExpired! || status == 9) ? null : onPressedFilledButton,
            ),
          ),
        ],
      ),
    );
  }

  getStatus(int status) {
    switch (status) {
      case 4:
        titleButton = 'Hết hạn';
        break;
      case 9: 
        titleButton = 'Đủ người';
        break;
      default:
        titleButton = AppStrings.shortApplyButton;
        break;
    }
  }
}
