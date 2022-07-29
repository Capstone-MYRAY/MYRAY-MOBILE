import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';

class CardStatusFieldNoWrap extends StatelessWidget {
  final String title;
  final String statusName;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;

  const CardStatusFieldNoWrap({
    Key? key,
    required this.title,
    required this.statusName,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title:',
          style: Get.textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(child: _buildStatus()),
      ],
    );
  }

  Widget _buildStatus() {
    return StatusChip(
      statusName: statusName,
      borderRadius: 20.0,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
    );
  }
}
