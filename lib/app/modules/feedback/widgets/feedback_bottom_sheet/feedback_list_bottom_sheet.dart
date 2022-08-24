import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

import 'feedback_list.dart';

class FeedbackListBottomSheet {
  static show(int belongedId) {
    Get.bottomSheet(
      ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.8,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            bottom: 8.0,
          ),
          child: FeedbackList(
            belongedId: belongedId,
          ),
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
