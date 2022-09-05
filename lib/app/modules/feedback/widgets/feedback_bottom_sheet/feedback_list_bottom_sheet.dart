import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

import 'feedback_list.dart';

class FeedbackListBottomSheet {
  static show(int belongedId) {
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.8,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 12.0,
              ),
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 12.0,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                "${AppStrings.titleFeedback}:",
                style: Get.textTheme.headline3!
                    .copyWith(color: AppColors.primaryColor),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: FeedbackList(
                belongedId: belongedId,
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      backgroundColor: AppColors.white,
      isScrollControlled: true,
    );
  }
}
