import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';

class FunctionCard extends StatelessWidget {
  final void Function()? feedback;
  final void Function()? report;
  final void Function()? bookmark;
  final bool? isBookmark;

  const FunctionCard(
      {Key? key,
      this.isBookmark = false,
      this.feedback,
      this.report,
      this.bookmark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          color: AppColors.white,
          child: Container(
            width: Get.width * 0.32,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.feedback_outlined,
                      size: 25,
                      color: AppColors.primaryColor,
                    ),
                    TextButton(
                      onPressed: feedback,
                      child: Text(
                        'Đánh giá',
                        style: Get.textTheme.headline6!.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.flag_outlined,
                      size: 25,
                      color: AppColors.primaryColor,
                    ),
                    TextButton(
                      onPressed: report,
                      child: Text(
                        'Báo cáo',
                        style: Get.textTheme.headline6!.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: bookmark,
                  child: Row(
                    children: [
                      isBookmark!
                          ? const Icon(
                              CustomIcons.heart,
                              size: 25,
                              color: Colors.red,
                            )
                          : const Icon(
                              CustomIcons.heart_outline,
                              size: 25,
                              color: Colors.red,
                            ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Yêu thích',
                        style: Get.textTheme.headline6!.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}

//Underline Text Button

// TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Báo cáo',
//                   style: Get.textTheme.headline5!.copyWith(
//                       color: AppColors.primaryColor,
//                       shadows: const [
//                         Shadow(
//                             color: AppColors.primaryColor,
//                             offset: Offset(0, -5))
//                       ],
//                       decoration: TextDecoration.underline,
//                       decorationColor: AppColors.primaryColor,
//                       decorationThickness: 1),
//                 ),
//               ),
