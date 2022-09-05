import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';

class ReportUpdateDialog {
  ReportUpdateDialog._();

  static show({
    required Report newReport,
    String? title
  }) {
    return Get.defaultDialog(
        title: title ?? 'Cập nhật báo cáo',
        titlePadding: const EdgeInsetsDirectional.only(top: 10),
        contentPadding: const EdgeInsets.all(20),
        titleStyle: Get.textTheme.headline3,
        content: Column(
          children: [
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
                    newReport.content,
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
        ));
  }
}
