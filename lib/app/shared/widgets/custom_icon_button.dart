import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class CustomIconButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData icon;
  final ShapeBorder? shape;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;
  final String? toolTip;
  final double? size;
  const CustomIconButton({
    Key? key,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.shape,
    this.onTap,
    this.size,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 0.0,
      vertical: 0.0,
    ),
    this.toolTip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      shape: shape,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Tooltip(
            message: toolTip,
            child: Icon(
              icon,
              color: foregroundColor ?? AppColors.iconColor,
              size: size,
            ),
          ),
        ),
      ),
    );
  }
}
