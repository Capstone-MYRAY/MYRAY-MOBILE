import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';

class FarmerInprogressJobCard extends StatelessWidget {
  final String job;
  final String address;
  final String startTime;
  final String endTime;
  final String? jobEndDate;
  final bool? isPayPerHourJob;
  final void Function()? extendJob;
  final void Function()? checkAttendance;
  final void Function() onLeave;
  final void Function() report;

  const FarmerInprogressJobCard({
    Key? key,
    required this.job,
    required this.address,
    required this.startTime,
    required this.endTime, 
    required this.report,
    required this.onLeave,
    this.jobEndDate,
    this.isPayPerHourJob = true,
    this.checkAttendance,
    this.extendJob,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(job,
                        style: Get.textTheme.headline3?.copyWith(
                          color: AppColors.brown,
                        ),
                        softWrap: true,
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            Row(children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 15, top: 10),
                child: Stack(
                  children: [
                    const Icon(CustomIcons.map_marker_outline, size: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
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
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        AppStrings.labelWorkingTime,
                        style: Get.textTheme.labelMedium,
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          Text(
                            startTime,
                            style: Get.textTheme.labelSmall!.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          Text(
                            ' - ',
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          Text(
                            endTime,
                            style: Get.textTheme.labelSmall!.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      CustomTextButton(
                        onPressed: report,
                        title: "Báo cáo",
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        AppStrings.labelPresentDate,
                        style: Get.textTheme.labelMedium,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
                        style: Get.textTheme.labelSmall!.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      CustomTextButton(
                        onPressed: onLeave,
                        title: AppStrings.labelOnLeave,
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                        foreground: AppColors.primaryColor,
                        background: AppColors.white,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        AppStrings.labelShortJobEndDate,
                        style: Get.textTheme.labelMedium,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        jobEndDate ?? 'Chưa xác định',
                        style: Get.textTheme.labelSmall!.copyWith(
                          color: AppColors.errorColor,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      isPayPerHourJob! 
                          ? CustomTextButton(
                              onPressed: checkAttendance ?? (){print('return attendance list');},
                              title: AppStrings.buttonCheckAttendance,
                            )
                          : CustomTextButton(
                              onPressed: extendJob ?? () {print('return form of extend job');},
                              title: AppStrings.extendButton,
                            ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
