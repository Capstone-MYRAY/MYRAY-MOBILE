import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';

class FarmerExtendJobCard extends StatelessWidget {
  final String title;
  final String address;
  final DateTime startOldDate;
  final DateTime startNewDate;
  final void Function() confirm;
  final String? message;
  final String? buttonLabel;

  const FarmerExtendJobCard(
      {Key? key,
      required this.title,
      required this.address,
      required this.startOldDate,
      required this.startNewDate,
      required this.confirm,
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
                Text(title,
                    style: Get.textTheme.headline3?.copyWith(
                      color: AppColors.brown,
                    ),
                    softWrap: true,
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis),
                const StatusChip(
                  statusName: "Chờ duyệt",
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ]),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(children: [
                Stack(
                  children: [
                    const Icon(CustomIcons.map_marker_outline, size: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width: Get.width * 0.65,
                        child: Text.rich(
                          TextSpan(
                            text: address,
                          ),
                          style: Get.textTheme.bodyText2!
                              .copyWith(fontSize: Get.textScaleFactor * 14),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          maxLines: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
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
                    "Ngày bắt đầu cũ:",
                    style: Get.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.textScaleFactor * 15,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.045,
                  ),
                  Text(
                    // startOldDate.toString(), //bỏ ngày sau
                    "07/07/2022",
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
                    "Ngày bắt đầu mới:",
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
                    "08/07/2022",
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
              CustomTextButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                onPressed: () {
                  CustomDialog.show(confirm: confirm, message: message!);
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
