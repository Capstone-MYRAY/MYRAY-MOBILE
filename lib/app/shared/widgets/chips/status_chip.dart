import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class StatusChip extends StatelessWidget {
  final String statusName;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;

  const StatusChip({
    Key? key,
    required this.statusName,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        color: backgroundColor ?? AppColors.grey,
      ),
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 6.0,
          ),
      child: Text(
        statusName,
        textAlign: TextAlign.center,
        style: Get.textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.45,
          color: foregroundColor ?? AppColors.white,
        ),
      ),
    );
  }
}
