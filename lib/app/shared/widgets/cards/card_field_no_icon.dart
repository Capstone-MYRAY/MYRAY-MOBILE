import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class CardFieldNoIcon extends StatelessWidget {
  final String title;
  final String data;
  const CardFieldNoIcon({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.backgroundColor,
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Get.textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: (Get.width * 0.9 - 32 * 2) / 2,
            ),
            child: Text(data),
          ),
        ],
      ),
    );
  }
}
