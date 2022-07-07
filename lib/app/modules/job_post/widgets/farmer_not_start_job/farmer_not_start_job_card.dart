import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';
import 'package:myray_mobile/app/shared/widgets/custom_confirm_dialog.dart';

class FarmerNotStartJobCard extends StatelessWidget {
  final String title;
  final String address;
  final DateTime startDate;
  final void Function() confirm;
  final String? message;
  final String? buttonLabel;

  const FarmerNotStartJobCard({
    Key? key,
    required this.title,
    required this.address,
    required this.startDate,
    required this.confirm,
    this.buttonLabel = 'Hủy',
    this.message = 'Bạn muốn thực hiện thao tác này'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(children: [
                Text(
                  title,
                    style: Get.textTheme.headline3?.copyWith(
                      color: AppColors.brown,
                    ),
                    softWrap: true,
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis),
              ]),
              SizedBox(
                height: Get.height * 0.015,
              ),
              Row(
                children: [
                  const Icon(CustomIcons.map_marker_outline, size: 20),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      address,
                      style: Get.textTheme.bodyText2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      maxLines: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.010,
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Row(children: [
                  const Icon(CustomIcons.calendar_star, size: 20),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Ngày bắt đầu:",
                    style: Get.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.textScaleFactor * 15,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    "07/07/2022",//bỏ ngày sau
                    style: Get.textTheme.bodyText2!.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: Get.textScaleFactor * 15,
                      fontWeight: FontWeight.w500
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 10,
                  ),
                ]),
              ),
              SizedBox(
                height: Get.height * 0.010,
              ),
              CustomTextButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                onPressed: () {
                  CustomDialog.show(
                      confirm: confirm,
                      message:
                          message!);
                },
                title: AppStrings.cancel,
                border: Border.all(
                  color: AppColors.primaryColor,
                ),
                foreground: AppColors.primaryColor,
                background: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
