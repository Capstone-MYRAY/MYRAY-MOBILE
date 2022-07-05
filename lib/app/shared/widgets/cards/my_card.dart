import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double elevation;
  const MyCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
    this.margin = const EdgeInsets.symmetric(vertical: 8.0),
    this.elevation = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.9,
      child: Card(
        elevation: elevation,
        margin: margin,
        color: AppColors.white,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
