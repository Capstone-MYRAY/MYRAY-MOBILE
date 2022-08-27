import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';

class FarmerInprogressJobCard extends StatelessWidget {
  final String job;
  final String address;
  final String startTime;
  final String endTime;
  final DateTime? jobEndDate;
  final bool? isPayPerHourJob;
  final JobPost jobPost;
  final void Function() moreDetail;

  const FarmerInprogressJobCard(
      {Key? key,
      required this.job,
      required this.address,
      required this.startTime,
      required this.endTime,
      required this.moreDetail,
      this.jobEndDate,
      this.isPayPerHourJob = true,
      required this.jobPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: moreDetail,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          color: AppColors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(jobPost.title,
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
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CardField(
                      icon: Icons.person,
                      title: 'Chủ vườn',
                      data: jobPost.publishedName ?? 'Tên chủ vườn',
                      iconAndTitleSpace: Get.width * 0.03,
                    ),
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    if (isPayPerHourJob!) ...[
                      CardField(
                        icon: Icons.timer_sharp,
                        title: AppStrings.labelWorkingTime,
                        data:
                            "${Utils.fromHHmm(startTime).format(context)} - ${Utils.fromHHmm(endTime).format(context)}",
                        iconAndTitleSpace: Get.width * 0.03,
                      ),
                      SizedBox(
                        height: Get.height * 0.005,
                      )
                    ],
                    // ? Row(
                    //     children: [
                    //       const Icon(Icons.timer_sharp, size: 20),
                    //       const SizedBox(
                    //         width: 10,
                    //       ),
                    //       Text(
                    //         "${AppStrings.labelWorkingTime}:",
                    //         style: Get.textTheme.labelMedium!.copyWith(
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: Get.textScaleFactor * 15,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: Get.width * 0.045,
                    //       ),
                    //       Text(
                    //         Utils.fromHHmm(startTime).format(context),
                    //         style: Get.textTheme.labelSmall!.copyWith(
                    //           color: AppColors.black,
                    //           fontSize: Get.textScaleFactor * 15,
                    //         ),
                    //       ),
                    //       Text(
                    //         ' - ',
                    //         style: Get.textTheme.labelMedium!.copyWith(
                    //           color: AppColors.black,
                    //           fontSize: Get.textScaleFactor * 15,
                    //         ),
                    //       ),
                    //       Text(
                    //         Utils.fromHHmm(endTime).format(context),
                    //         style: Get.textTheme.labelSmall!.copyWith(
                    //           color: AppColors.black,
                    //           fontSize: Get.textScaleFactor * 15,
                    //         ),
                    //       ),
                    //     ],
                    //   )
                    // Row(
                    //   children: [
                    //     const Icon(Icons.calendar_today_outlined, size: 20),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text(
                    //       "${AppStrings.labelPresentDate}:",
                    //       style: Get.textTheme.labelMedium!.copyWith(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: Get.textScaleFactor * 15,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: Get.width * 0.03,
                    //     ),
                    //     Text(
                    //       DateFormat('dd-MM-yyyy')
                    //           .format(DateTime.now())
                    //           .toString(),
                    //       style: Get.textTheme.labelSmall!.copyWith(
                    //         color: AppColors.primaryColor,
                    //         fontSize: Get.textScaleFactor * 15,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    CardField(
                      icon: Icons.calendar_today_outlined,
                      title: AppStrings.labelPresentDate,
                      data: DateFormat('dd-MM-yyyy')
                          .format(DateTime.now())
                          .toString(),
                      iconAndTitleSpace: Get.width * 0.03,
                    ),
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    // Row(
                    //   children: [
                    //     const Icon(Icons.calendar_month, size: 20),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text(
                    //       "${AppStrings.labelShortJobEndDate}:",
                    //       style: Get.textTheme.labelMedium!.copyWith(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: Get.textScaleFactor * 15,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: Get.width * 0.02,
                    //     ),
                    //     Text(
                    //       jobEndDate ?? 'Chưa kết thúc',
                    //       style: Get.textTheme.labelSmall!.copyWith(
                    //         color: AppColors.errorColor,
                    //         fontSize: Get.textScaleFactor * 15,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    CardField(
                      icon: Icons.calendar_month,
                      title: AppStrings.labelShortJobEndDate,
                      data: jobEndDate != null
                          ? Utils.formatddMMyyyy(jobEndDate!)
                          : 'Chưa kết thúc',
                      iconAndTitleSpace: Get.width * 0.03,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
