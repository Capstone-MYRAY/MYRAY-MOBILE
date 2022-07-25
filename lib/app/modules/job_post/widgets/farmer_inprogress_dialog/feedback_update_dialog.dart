import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';

class FeedBackUpdateDialog {
  FeedBackUpdateDialog._();

  static show({
    required FeedBack newFeedBack,
  }) {
    return Get.defaultDialog(
        title: 'Cập nhật đánh giá',
        titlePadding: const EdgeInsets.only(top: 20),
        contentPadding: const EdgeInsets.all(20),
        titleStyle: Get.textTheme.headline3,
        content: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.star_border_rounded,
                    size: 18,
                    color: Colors.black,
                  ),
                  SizedBox(width: Get.height * 0.01),
                  Text(
                    'Mức độ đánh giá:',
                    style: Get.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.textScaleFactor * 17,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.01),
              Row(
                children: [
                  SizedBox(width: Get.width * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBarIndicator(
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: Get.textScaleFactor * 35,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                          rating: double.parse(newFeedBack.numStar.toString()))
                    ],
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Row(
                children: [
                  const Icon(
                    Icons.content_copy_rounded,
                    size: 17,
                    color: AppColors.black,
                  ),
                  SizedBox(width: Get.height * 0.01),
                  Text(
                    'Nội dung cập nhật:',
                    style: Get.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.textScaleFactor * 17,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.01),
              Row(
                children: [
                  SizedBox(width: Get.width * 0.07),
                  Expanded(
                    //valid giới hạn lại số chữ nhập
                    child: Text(
                      newFeedBack.content,
                      style: Get.textTheme.bodyText2!
                          .copyWith(fontSize: Get.textScaleFactor * 16),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      maxLines: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Row(
                children: [
                  const Icon(
                    Icons.date_range_outlined,
                    size: 17,
                    color: AppColors.black,
                  ),
                  SizedBox(width: Get.height * 0.01),
                  Text(
                    'Ngày cập nhật:',
                    style: Get.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.textScaleFactor * 17,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.01),
              Row(
                children: [
                  SizedBox(width: Get.width * 0.07),
                  Expanded(
                    child: Text(
                      Utils.formatHHmmddMMyyyy(DateTime.now()),
                      style: Get.textTheme.bodyText2!
                          .copyWith(fontSize: Get.textScaleFactor * 16),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              CustomTextButton(
                  onPressed: () {
                    Get.back();
                  },
                  title: 'Đóng',
                  border: Border.all(
                    color: AppColors.primaryColor,
                  ),
                  foreground: AppColors.primaryColor,
                  background: AppColors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.08, vertical: 9)),
            ],
          ),
        ));
  }
}
