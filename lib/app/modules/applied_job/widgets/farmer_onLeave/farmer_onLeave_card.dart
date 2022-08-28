import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';

class FarmerOnLeaveCard extends StatelessWidget {
  final String job;
  final DateTime submitDate;
  final DateTime dayOffDate;
  final int numOfOnleaveDays;
  final String reason;
  final void Function()? onTap;
  //final DateTime createdDate;

  const FarmerOnLeaveCard(
      {Key? key,
      required this.job,
      required this.submitDate,
      required this.dayOffDate,
      required this.numOfOnleaveDays,
      required this.reason,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              Text('Đơn xin nghỉ phép',
                  style: Get.textTheme.headline4?.copyWith(
                    color: AppColors.brown,
                    decoration: TextDecoration.underline,
                  ),
                  softWrap: true,
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis),
              SizedBox(
                height: Get.height * 0.02,
              ),
              CardField(
                  icon: CustomIcons.briefcase_outline,
                  title: "Công việc",
                  data: job,
                  iconAndTitleSpace: Get.width * 0.03,
                  dataColor: AppColors.primaryColor),
              SizedBox(
                height: Get.height * 0.010,
              ),
              // Row(children: [
              //   const Icon(CustomIcons.briefcase_outline, size: 20),
              //   SizedBox(
              //     width: Get.width * 0.03,
              //   ),
              //   Text(
              //     "Công việc:",
              //     style: Get.textTheme.labelMedium!.copyWith(
              //       fontWeight: FontWeight.w500,
              //       fontSize: Get.textScaleFactor * 15,
              //     ),
              //   ),
              //   SizedBox(width: Get.width * 0.025),
              //   Expanded(
              //     child: Padding(
              //       padding: const EdgeInsets.only(right: 15),
              //       child: Text(
              //         job,
              //         style: Get.textTheme.labelMedium!.copyWith(
              //           fontWeight: FontWeight.w500,
              //           fontSize: Get.textScaleFactor * 15,
              //         ),
              //         softWrap: true,
              //         overflow: TextOverflow.ellipsis,
              //         textAlign: TextAlign.justify,
              //         maxLines: 3,
              //       ),
              //     ),
              //   ),
              // ]),           
               CardField(
                  icon: CustomIcons.calendar_minus,
                  title: "Ngày nghỉ",
                  data: Utils.formatddMMyyyy(dayOffDate),
                  iconAndTitleSpace: Get.width * 0.03,
                  dataColor: AppColors.primaryColor),
              SizedBox(
                height: Get.height * 0.010,
              ),             
              CardField(
                  icon: CustomIcons.calendar_range,
                  title: "Ngày nộp đơn",
                  data: Utils.formatddMMyyyy(submitDate),
                  iconAndTitleSpace: Get.width * 0.03,
                  dataColor: AppColors.primaryColor),
              SizedBox(
                height: Get.height * 0.01,
              ),              
              SizedBox(
                height: Get.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
