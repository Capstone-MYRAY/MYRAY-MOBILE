import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class CardField extends StatelessWidget {
  final IconData icon;
  final String title;
  final String data;

  const CardField({
    Key? key,
    required this.icon,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              children: [
                TextSpan(
                  text: title + ': ',
                  style: Get.textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: data,
                  style: Get.textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
