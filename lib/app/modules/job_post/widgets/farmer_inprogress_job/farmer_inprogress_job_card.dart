import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_form_dialog.dart';

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
                            text: 'Địa chỉ:  ',
                            children: [
                              TextSpan(
                                text: address,
                                style: Get.textTheme.bodyText2!.copyWith(
                                    fontSize: Get.textScaleFactor * 15),
                              ),
                            ],
                            style: Get.textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: Get.textScaleFactor * 15,
                            ),
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          maxLines: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer_sharp, size: 20),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppStrings.labelWorkingTime + ":",
                        style: Get.textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.045,
                      ),
                      Text(
                        startTime,
                        style: Get.textTheme.labelSmall!.copyWith(
                          color: AppColors.black,
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                      Text(
                        ' - ',
                        style: Get.textTheme.labelMedium!.copyWith(
                          color: AppColors.black,
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                      Text(
                        endTime,
                        style: Get.textTheme.labelSmall!.copyWith(
                          color: AppColors.black,
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.005,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 20),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppStrings.labelPresentDate + ":",
                        style: Get.textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy')
                            .format(DateTime.now())
                            .toString(),
                        style: Get.textTheme.labelSmall!.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.005,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, size: 20),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppStrings.labelShortJobEndDate + ":",
                        style: Get.textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Text(
                        jobEndDate ?? 'Chưa xác định',
                        style: Get.textTheme.labelSmall!.copyWith(
                          color: AppColors.errorColor,
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextButton(
              onPressed: () {
                CustomFormDialog.showDialog(
                  title: 'Yêu cầu',
                  textFields: [
                    _buildSimpleIcon(),
                    _buildTabDialog(
                      function: onLeave,
                      label: AppStrings.buttonOnLeave,
                      iconData: CustomIcons.calendar_minus,
                    ),
                    isPayPerHourJob!
                        ? _buildTabDialog(
                            function: checkAttendance ??
                                () {
                                  print('return attendance list');
                                },
                            label: AppStrings.buttonCheckAttendance,
                            iconData: Icons.check_circle_outline,
                          )
                        : _buildTabDialog(
                            function: extendJob ??
                                () {
                                  print('return form of extend job');
                                },
                            label: AppStrings.extendButton,
                            iconData: Icons.edit_calendar_outlined,
                          ),
                    _buildTabDialog(
                      function: report,
                      label: AppStrings.reportJobProblem,
                      iconData: Icons.report_problem_outlined,
                    ),
                  ],
                  cancel: () {
                    Get.back();
                  },
                );
              },
              title: 'Yêu cầu',
              border: Border.all(
                color: AppColors.primaryColor,
              ),
              foreground: AppColors.primaryColor,
              background: AppColors.white,
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabDialog({
    required void Function() function,
    required String label,
    required IconData iconData,
  }) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border(
            bottom: BorderSide(
              color: AppColors.primaryColor,
              // width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 25,
              color: AppColors.primaryColor,
            ),
            SizedBox(
              width: Get.width * 0.04,
            ),
            Text(
              label,
              style: Get.textTheme.titleLarge!.copyWith(
                  color: AppColors.brown, fontSize: Get.textScaleFactor * 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleIcon() {
    return Center(
      child: Column(
        children: [
          Image.asset(AppAssets.cultivation, scale: 25),
        ],
      ),
    );
  }
}
