import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class CardField extends StatelessWidget {
  final IconData icon;
  final String title;
  final String data;
  final bool isCenter;
  final Color? dataColor;
  final double? fontSize;
  final FontWeight? titleFontWeight;

  const CardField({
    Key? key,
    required this.icon,
    required this.title,
    required this.data,
    this.isCenter = false,
    this.dataColor,
    this.fontSize,
    this.titleFontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColors.iconColor,
        ),
        const SizedBox(width: 5.0),
        Expanded(
          child: RichText(
            softWrap: true,
            textScaleFactor: Get.textScaleFactor,
            text: TextSpan(
              style: Get.textTheme.bodyText2!.copyWith(
                height: 1.3,
              ),
              children: [
                TextSpan(
                  text: '$title: ',
                  style: Get.textTheme.bodyText2!.copyWith(
                    fontWeight: titleFontWeight ?? FontWeight.w500,
                    fontSize: fontSize,
                  ),
                ),
                TextSpan(
                  text: data,
                  style: Get.textTheme.bodyText2!.copyWith(
                    color: dataColor ?? AppColors.black,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
