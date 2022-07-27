import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/base_dialog.dart';

class FeedbackDialog {
  static Future<bool?> show(
      void Function(double ratedStar, String content) feedbackFn,
      {FeedBack? feedback}) async {
    final detailsController = TextEditingController(
      text: feedback?.content,
    );
    String? error;
    double selectedStar = 0.0;

    return await BaseDialog.show(
      child: StatefulBuilder(
        builder: (context, setState) => Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                feedback == null
                    ? AppStrings.titleFeedback
                    : 'Chỉnh sửa đánh giá',
                style: Get.textTheme.headline4!.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            RatingBar(
              initialRating:
                  feedback != null ? feedback.numStar.toDouble() : 0.0,
              itemCount: 5,
              direction: Axis.horizontal,
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              // allowHalfRating: true,
              ratingWidget: RatingWidget(
                full: const Icon(
                  CustomIcons.star,
                  color: AppColors.starColor,
                  size: 20.0,
                ),
                half: const Icon(
                  CustomIcons.star_half,
                  color: AppColors.starColor,
                  size: 20.0,
                ),
                empty: const Icon(
                  CustomIcons.star_outline,
                  color: AppColors.starColor,
                  size: 20.0,
                ),
              ),
              onRatingUpdate: (value) {
                selectedStar = value;
                if (error != null) {
                  setState(() {
                    error = null;
                  });
                }
              },
            ),
            if (error != null)
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                child: Text(
                  error!,
                  style: Get.textTheme.caption!.copyWith(
                    color: AppColors.errorColor,
                  ),
                ),
              ),
            const SizedBox(height: 16.0),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(
                labelText: 'Chi tiết',
                hintText: 'Chi tiết đánh giá (không bắt buộc)',
              ),
              minLines: 1,
              maxLines: 5,
            ),
            const SizedBox(height: 24.0),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: FilledButton(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                title: feedback == null
                    ? AppStrings.titleFeedback
                    : AppStrings.titleUpdate,
                onPressed: () {
                  if (selectedStar == 0) {
                    setState(() {
                      error = 'Vui lòng chọn số sao';
                    });
                    return;
                  }

                  feedbackFn(selectedStar, detailsController.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
