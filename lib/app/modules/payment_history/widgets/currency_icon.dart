import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';

class CurrencyIcon extends StatelessWidget {
  final Color iconColor;
  final double iconSize;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const CurrencyIcon({
    Key? key,
    required this.iconColor,
    this.margin = const EdgeInsets.symmetric(
      vertical: 4.0,
      horizontal: 8.0,
    ),
    this.padding = const EdgeInsets.all(4.0),
    this.iconSize = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          width: 1,
          color: iconColor,
        ),
      ),
      child: Icon(
        CustomIcons.currency_usd,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
