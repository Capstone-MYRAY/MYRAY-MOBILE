import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  final Color? foreground;
  final Color? background;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;
  final void Function() onPressed;
  final String title;
  final num? titleSize;
  TextStyle? textStyle;

  CustomTextButton(
      {Key? key,
      this.foreground = AppColors.white,
      this.background = AppColors.primaryColor,
      this.border,
      this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      this.titleSize,
      this.textStyle,
      required this.onPressed,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: background,
            border: border,
          ),
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: textStyle ?? Get.textTheme.labelLarge!.copyWith(
                  color: foreground,
                ),
              ),
            ],
          ),
        ));
  }
}
