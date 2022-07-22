import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';

class FarmerAttendanceDetailDialog {
  FarmerAttendanceDetailDialog._();

  static show(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 500),
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
        return SingleChildScrollView(
          child: SafeArea(
            child: Container(
              width: Get.width,
              height: Get.height + Get.height * 0.1,
              padding: const EdgeInsets.all(20),
              color: AppColors.backgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
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
                    height: Get.height * 0.05,
                  ),
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
                    height: Get.height * 0.05,
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
                            label: 'Chủ đất:', content: 'Hồ Đình Tùng Lâm'),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        _buildRowInformation(
                            label: 'Họ và tên:',
                            content: 'Nguyễn Phan Quỳnh Anh'),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        _buildRowInformation(
                            label: 'Loại công việc:', content: 'Làm công'),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        _buildRowInformation(
                            label: 'Công việc:', content: 'Thu hoạch cà phê'),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        _buildRowInformation(
                            label: 'Ngày nhận tiền:', content: '23/07/2021'),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        _buildRowInformation(
                            label: 'Số tiền nhận:',
                            content: '50.000 đ',
                            contentColor: AppColors.primaryColor),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        _buildRowInformation(
                            label: 'Nội dung:', content: 'Tiền nhận ngày 1'),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Text('Chữ ký xác nhận', style: Get.textTheme.headline4),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Container(
                            padding: const EdgeInsets.all(25),
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.grey.withOpacity(0.5),
                            ),
                            child: const Center(
                              child: Text('Đã ký'),
                            )),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  CustomTextButton(
                    onPressed: () {},
                    title: 'Báo cáo sai sót',
                    background: AppColors.errorColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.2, vertical: 10),
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
