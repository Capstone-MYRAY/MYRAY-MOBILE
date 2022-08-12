import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';

class WorkTypeChip extends StatelessWidget {
  final String? workType;
  final double? borderRadiusSize;
  const WorkTypeChip({Key? key, this.workType = "", this.borderRadiusSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusSize ?? 3),
        color: AppColors.primaryColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(workType!,
              textAlign: TextAlign.center,
              style: Get.textTheme.caption!.copyWith(color: AppColors.white)),
        ],
      ),
    );
  }
}
