import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';

class FarmerExtendJobCard extends StatelessWidget {
  final String title;
  final DateTime startOldDate;
  final DateTime startNewDate;
  final DateTime createdDate;
  final int status;
  final void Function() confirmButtonLeft;
  final void Function() confirmButtonRight;
  final String? message;
  final String? buttonLabel;

  const FarmerExtendJobCard(
      {Key? key,
      required this.title,
      required this.startOldDate,
      required this.startNewDate,
      required this.createdDate,
      required this.status,
      required this.confirmButtonLeft,
      required this.confirmButtonRight,
      this.buttonLabel = 'Hủy',
      this.message = 'Bạn muốn thực hiện thao tác này'})
      : super(key: key);

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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  child: Text(title,
                      style: Get.textTheme.headline4?.copyWith(
                          color: AppColors.brown,
                          fontSize: Get.textScaleFactor * 25),
                      softWrap: true,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis),
                ),
                _buildChip(status),
              ]),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(children: [
                  const Icon(Icons.calendar_month, size: 20),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Ngày nộp đơn:",
                    style: Get.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.textScaleFactor * 15,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.09,
                  ),
                  Text(
                    // startOldDate.toString(), //bỏ ngày sau
                    DateFormat('dd/MM/yyyy').format(createdDate),
                    style: Get.textTheme.bodyText2!.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: Get.textScaleFactor * 15,
                        fontWeight: FontWeight.w500),
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
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(children: [
                  const Icon(CustomIcons.calendar_star, size: 20),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Ngày kết thúc cũ:",
                    style: Get.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.textScaleFactor * 15,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.040,
                  ),
                  Text(
                    // startOldDate.toString(), //bỏ ngày sau
                    DateFormat('dd/MM/yyyy').format(startOldDate),
                    style: Get.textTheme.bodyText2!.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: Get.textScaleFactor * 15,
                        fontWeight: FontWeight.w500),
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
              Padding(
                padding: EdgeInsets.all(0),
                child: Row(children: [
                  const Icon(CustomIcons.calendar_star, size: 20),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Ngày kết thúc mới:",
                    style: Get.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.textScaleFactor * 15,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    // startNewDate.toString(), //bỏ ngày sau
                    DateFormat('dd/MM/yyyy').format(startNewDate),
                    style: Get.textTheme.bodyText2!.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: Get.textScaleFactor * 15,
                        fontWeight: FontWeight.w500),
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
             status == 0
             ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                CustomTextButton(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05,
                    vertical: 8,
                  ),
                  onPressed: confirmButtonLeft,
                  title: 'Cập nhật',
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                CustomTextButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  onPressed: () {
                    CustomDialog.show(confirm: confirmButtonRight, message: message!);
                  },
                  title: AppStrings.cancel,
                  border: Border.all(
                    color: AppColors.primaryColor,
                  ),
                  foreground: AppColors.primaryColor,
                  background: AppColors.white,
                ),
              ])
              : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(int status) {
    Widget chip = const SizedBox();
    switch (status) {
      case 0:
        chip = const StatusChip(
          statusName: "Chờ duyệt",
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        );
        break;
      case 1:
        chip = const StatusChip(
          statusName: "Đã duyệt",
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        );
        break;
      case 2:
        chip = StatusChip(
          statusName: "Từ chối",
          backgroundColor: AppColors.grey.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        );
        break;
    }
    return chip;
  }
}
