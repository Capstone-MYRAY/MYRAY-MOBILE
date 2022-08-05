import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/history_job/widgets/farmer_history_detail/function_card.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';

class LandOwnerCard extends StatelessWidget {
  final void Function()? feedback;
  final void Function()? report;
  final void Function()? bookmark;
  final bool? isBookmark;
  final String name;
  final String address;
  const LandOwnerCard(
      {Key? key,
      required this.name,
      required this.address,
      this.isBookmark = false,
      this.feedback,
      this.report,
      this.bookmark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(9),
      // ),
      color: AppColors.white,
      child: Container(
        // width: Get.width * 0.90,
        width: Get.width,
        padding: const EdgeInsets.all(10),
        // width: Get.width * 0.55,
        child: Row(
          children: [
            Expanded(
              child: Container(
                //canh lề cho thông tin chủ rẫy
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          CustomIcons.person,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            name,
                            style: Get.textTheme.bodyText2!.copyWith(
                              fontSize: Get.textScaleFactor * 15,
                            ),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          CustomIcons.map_marker_outline,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: 120,
                          child: Text(
                            address,
                            style: Get.textTheme.bodyText2!.copyWith(
                              fontSize: Get.textScaleFactor * 15,
                            ),
                            softWrap: true,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: FunctionCard(
                feedback: feedback,
                report: report,
                bookmark: bookmark,
                isBookmark: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
