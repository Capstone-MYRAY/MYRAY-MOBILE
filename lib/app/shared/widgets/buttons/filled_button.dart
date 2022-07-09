import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class FilledButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final double minWidth;
  final double minHeight;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const FilledButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.minWidth = double.infinity,
    this.minHeight = CommonConstants.buttonHeight,
    this.padding,
    this.color = AppColors.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(minWidth, minHeight),
          padding: padding,
          primary: color,
        ),
        child: Text(title),
      ),
    );
  }
}
