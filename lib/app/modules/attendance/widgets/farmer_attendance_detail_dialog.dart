import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';

class FarmerAttendanceDetailDialog {
  FarmerAttendanceDetailDialog._();

  static show(BuildContext context, Attendance attendance, String jobTitle) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Card(
          child: Container(
            width: Get.width,
            // height: Get.height + Get.height * 0.03,
            padding: const EdgeInsets.all(20),
            color: AppColors.backgroundColor,
            child:
                 SingleChildScrollView(
                  child:
                Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Điểm danh', style: Get.textTheme.headline3),
                    IconButton(
                      icon: const Icon(Icons.close,
                          size: 40, color: AppColors.brown),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: Text('Bản xác nhận\ntiền công',
                            style: Get.textTheme.headline3!.copyWith(
                              color: AppColors.white,
                            ),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            _buildRowInformation(
                                label: 'Loại công việc:', content: 'Làm công'),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            _buildRowInformation(
                                label: 'Công việc:', content: jobTitle),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            _buildRowInformation(
                                label: 'Ngày nhận tiền:',
                                content: Utils.formatddMMyyyy(attendance.date)),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            _buildRowInformation(
                                label: 'Số tiền nhận:',
                                content: Utils.vietnameseCurrencyFormat
                                    .format(attendance.salary),
                                contentColor: AppColors.primaryColor),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            // _buildRowInformation(
                            //     label: 'Điểm thưởng:',
                            //     content: '${attendance.bonusPoint} điểm'),
                            // SizedBox(
                            //   height: Get.height * 0.03,
                            // ),
                            // _buildRowInformation(
                            //     label: 'Nội dung:',
                            //     content:
                            //         'Nhận tiền công ngày ${Utils.formatddMMyyyy(attendance.date)}'),
                            // SizedBox(
                            //   height: Get.height * 0.03,
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white,
                        ),
                        child: ClipRRect(
                          child: Card(
                            child: Column(
                              children: [
                                SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                Text(AppStrings.titleConfirmSignature,
                                    style: Get.textTheme.headline4),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),                                
                                Image.network(
                                  attendance.signature ?? 'https://luatacc.com/wp-content/uploads/2022/02/chu-ky-la-gi.png',
                                  width: Get.width * 0.9,
                                  height: Get.height * 0.2,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value:
                                            loadingProgress.expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      // CustomTextButton(
                      //   onPressed: () {},
                      //   title: 'Báo cáo sai sót',
                      //   background: AppColors.errorColor,
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: Get.width * 0.2, vertical: 10),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ),
        );
      },
    );
  }

  static Widget _buildRowInformation({
    required String label,
    required String content,
    Color? contentColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Get.textTheme.labelMedium!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: Get.textScaleFactor * 16,
          ),
        ),
        SizedBox(
          width: Get.width * 0.03,
        ),
        Expanded(
          child: Text(
            content,
            style: Get.textTheme.labelMedium!.copyWith(
                fontSize: Get.textScaleFactor * 16,
                color: contentColor ?? AppColors.black),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
