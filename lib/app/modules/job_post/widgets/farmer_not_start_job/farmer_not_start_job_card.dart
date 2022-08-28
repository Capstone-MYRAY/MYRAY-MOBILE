import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/base_dialog.dart';

class FarmerNotStartJobCard extends StatelessWidget {
  final String title;
  final String address;
  final String startDate;
  // final void Function() confirm;
  final String? message;
  final String? buttonLabel;
  final JobPost jobPost;

  const FarmerNotStartJobCard({
    Key? key,
    required this.title,
    required this.address,
    required this.startDate,
    // required this.confirm,
    this.buttonLabel = 'Hủy',
    this.message = 'Bạn muốn thực hiện thao tác này',
    required this.jobPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BaseDialog.show(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 25,
            // vertical: Get.height * 0.3,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(AppStrings.titleDetails,
                    style: Get.textTheme.headline4!.copyWith(
                      color: AppColors.primaryColor,
                    )),
                if (jobPost.type == 'PayPerHourJob') ...[
                  const SizedBox(
                    height: 10,
                  ),
                  CardField(
                    icon: Icons.timer_sharp,
                    title: AppStrings.labelWorkingTime,
                    data:
                        "${Utils.fromHHmm(jobPost.payPerHourJob!.startTime).format(context)} - ${Utils.fromHHmm(jobPost.payPerHourJob!.finishTime).format(context)}",
                  ),
                ],
                if (jobPost.type == 'PayPerTaskJob') ...[
                  const SizedBox(
                    height: 10,
                  ),
                  CardField(
                    icon: CustomIcons.calendar_check,
                    title: AppStrings.labelShortJobEndDate,
                    data:
                        Utils.formatddMMyyyy(jobPost.payPerTaskJob!.finishTime!),
                  ),
                ],
                const SizedBox(
                  height: 10,
                ),
                CardField(
                  icon: CustomIcons.map_marker_outline,
                  title: AppStrings.labelAddress,
                  data: address,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
      child: Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15.0, right: 11, top: 10, bottom: 10),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(children: [
                Text(title,
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
              //  Row(
              //   children: [
              //   Stack(
              //     children: [
              //       const Icon(CustomIcons.map_marker_outline, size: 20),

              //       Padding(
              //         padding: EdgeInsets.only(left: 30),
              //         child: SizedBox(
              //           width: Get.width * 0.65,
              //           child: Text.rich(

              //             TextSpan(
              //               text: address,
              //             ),
              //             style: Get.textTheme.bodyText2!
              //                 .copyWith(fontSize: Get.textScaleFactor * 14),
              //             softWrap: true,
              //             overflow: TextOverflow.ellipsis,
              //             textAlign: TextAlign.justify,
              //             maxLines: 10,

              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              //   ]
              // ),
              CardField(
                icon: Icons.person,
                title: 'Chủ vườn',
                data: jobPost.publishedName ?? 'Tên chủ vườn',
                iconAndTitleSpace: Get.width * 0.03,
              ),
              SizedBox(
                height: Get.height * 0.010,
              ),
              CardField(
                icon: CustomIcons.briefcase_outline,
                title: AppStrings.labelWorkType,
                data: jobPost.workTypeName,
                iconAndTitleSpace: Get.width * 0.03,
              ),
              SizedBox(
                height: Get.height * 0.010,
              ),
              CardField(
                icon: CustomIcons.calendar_star,
                title: AppStrings.labelJobStartDate,
                data: startDate,
                iconAndTitleSpace: Get.width * 0.03,
                dataColor: AppColors.primaryColor,
              ),

              // Padding(
              //   padding: EdgeInsets.all(0),
              //   child: Row(children: [
              //     const Icon(CustomIcons.calendar_star, size: 20),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     Text(
              //       "Ngày bắt đầu:",
              //       style: Get.textTheme.labelMedium!.copyWith(
              //         fontWeight: FontWeight.w500,
              //         fontSize: Get.textScaleFactor * 15,
              //       ),
              //     ),
              //     SizedBox(
              //       width: Get.width * 0.02,
              //     ),
              //     Text(
              //       startDate, //bỏ ngày sau
              //       style: Get.textTheme.bodyText2!.copyWith(
              //           color: AppColors.primaryColor,
              //           fontSize: Get.textScaleFactor * 15,
              //           fontWeight: FontWeight.w500),
              //       softWrap: true,
              //       overflow: TextOverflow.ellipsis,
              //       textAlign: TextAlign.left,
              //       maxLines: 10,
              //     ),
              //   ]),
              // ),
              SizedBox(
                height: Get.height * 0.010,
              ),
              // CustomTextButton(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
              //   onPressed: () {
              //     CustomDialog.show(confirm: confirm, message: message!);
              //   },
              //   title: AppStrings.cancel,
              //   border: Border.all(
              //     color: AppColors.primaryColor,
              //   ),
              //   foreground: AppColors.primaryColor,
              //   background: AppColors.white,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
