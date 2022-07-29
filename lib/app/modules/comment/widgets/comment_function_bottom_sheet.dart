import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';

class CommentFunctionBottomSheet {
  CommentFunctionBottomSheet._();

  static showMenu({
    required BuildContext context,
    required void Function() delete,
    required void Function() edit,
  }) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: ((context) {
          return Container(
              height: Get.height * 0.2,
              margin: const EdgeInsets.only(left: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: delete,
                    child: Row(
                      children: [
                        const ImageIcon(AssetImage(AppAssets.trash),
                            color: AppColors.black, size: 40),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          AppStrings.titleDelete,
                          style: Get.textTheme.labelMedium!.copyWith(
                            fontSize: Get.textScaleFactor * 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: edit,
                    child: Row(
                      children: [
                        const ImageIcon(AssetImage(AppAssets.edit),
                            color: AppColors.black, size: 35),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          AppStrings.titleEdit,
                          style: Get.textTheme.labelMedium!.copyWith(
                            fontSize: Get.textScaleFactor * 20,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        }));
  }
}
