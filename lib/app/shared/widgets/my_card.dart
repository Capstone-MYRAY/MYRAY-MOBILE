import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final double vertialPadding;
  final double horizontalPadding;
  const MyCard({
    Key? key,
    required this.child,
    this.vertialPadding = 16.0,
    this.horizontalPadding = 32.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.9,
      child: Card(
        color: AppColors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: vertialPadding,
            horizontal: horizontalPadding,
          ),
          child: child,
        ),
      ),
    );
  }
}
