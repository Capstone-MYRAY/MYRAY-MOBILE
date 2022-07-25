import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class EquationDisplay extends StatelessWidget {
  final String equation;
  final String cost;
  final bool isReduce;
  final EdgeInsets padding;

  const EquationDisplay({
    Key? key,
    required this.equation,
    required this.cost,
    this.isReduce = true,
    this.padding = const EdgeInsets.only(left: 25 + 15),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            equation,
            style: Get.textTheme.caption,
          ),
          SizedBox(width: Get.width * 0.1),
          Text(
            cost,
            style: Get.textTheme.caption!.copyWith(
              color: isReduce ? AppColors.errorColor : AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
