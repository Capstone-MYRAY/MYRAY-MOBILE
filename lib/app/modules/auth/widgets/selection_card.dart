import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class SelectionCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String caption;
  final bool isSelected;
  final void Function()? onTap;

  const SelectionCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.caption,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  BorderSide get selected => isSelected
      ? const BorderSide(
          color: AppColors.primaryColor,
          width: 4.0,
          style: BorderStyle.solid,
        )
      : BorderSide.none;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.8 / 2 - 6,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: CommonConstants.elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
            side: selected,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      imagePath,
                      width: 100.0,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      title,
                      style: Get.textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  caption,
                  style: Get.textTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
