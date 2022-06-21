import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class StatusChip extends StatelessWidget {
  final String statusName;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsetsGeometry padding;

  const StatusChip({
    Key? key,
    required this.statusName,
    this.backgroundColor = AppColors.grey,
    this.foregroundColor = AppColors.white,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 10.0,
      vertical: 6.0,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
      ),
      padding: padding,
      child: Text(
        statusName,
        textAlign: TextAlign.center,
        style: Get.textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.45,
          color: foregroundColor,
        ),
      ),
    );
  }
}
