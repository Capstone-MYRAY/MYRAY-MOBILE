import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';

class FarmerOnLeaveCard extends StatelessWidget {
  final String job;
  final DateTime submitDate;
  final int numOfOnleaveDays;
  final String reason;
  // final void Function() onTap;


  const FarmerOnLeaveCard({
    Key? key,
    required this.job,
    required this.submitDate,
    required this.numOfOnleaveDays,
    required this.reason,
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
              Text('Đơn xin nghỉ phép',
                  style: Get.textTheme.headline3?.copyWith(
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
              Row(children: [
                Stack(
                  children: [
                    const Icon(CustomIcons.briefcase_outline, size: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width: Get.width * 0.7,
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: "Công việc:  ",
                              style: Get.textTheme.labelMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: Get.textScaleFactor * 15,
                              ),
                            ),
                            TextSpan(
                              text: job,
                              style: Get.textTheme.bodyText2!.copyWith(
                                fontSize: Get.textScaleFactor * 15,
                              ),
                            ),
                          ]),
                          style: Get.textTheme.bodyText2!
                              .copyWith(fontSize: Get.textScaleFactor * 14),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(children: [
                  const Icon(CustomIcons.calendar_range, size: 20),
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
                    width: Get.width * 0.045,
                  ),
                  Text(
                    // submitDate.toString(), //bỏ ngày sau
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
                height: Get.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(children: [
                  const Icon(CustomIcons.calendar_minus, size: 20),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Số ngày nghỉ:",
                    style: Get.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.textScaleFactor * 15,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.06,
                  ),
                  Text(
                    "$numOfOnleaveDays ngày",
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
                height: Get.height * 0.01,
              ),
              Row(children: [
                Stack(
                  children: [
                    const Icon(CustomIcons.pencil, size: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width: Get.width * 0.7,
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: "Lý do:  ",
                              style: Get.textTheme.labelMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: Get.textScaleFactor * 15,
                              ),
                            ),
                            TextSpan(
                              text: reason,
                              style: Get.textTheme.bodyText2!.copyWith(
                                fontSize: Get.textScaleFactor * 15,
                              ),
                            ),
                          ]),
                          style: Get.textTheme.bodyText2!
                              .copyWith(fontSize: Get.textScaleFactor * 14),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
