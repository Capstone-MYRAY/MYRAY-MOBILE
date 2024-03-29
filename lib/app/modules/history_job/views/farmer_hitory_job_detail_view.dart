import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/modules/attendance/widgets/farmer_attendance_detail_dialog.dart';
import 'package:myray_mobile/app/modules/history_job/controllers/farmer_history_job_detail_controller.dart';
import 'package:myray_mobile/app/modules/history_job/widgets/farmer_history_detail/information_work_card.dart';
import 'package:myray_mobile/app/modules/history_job/widgets/farmer_history_detail/landowner_cart.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/base_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_information.dialog.dart';

class FarmerHistoryJobDetail extends GetView<FarmerHistoryJobDetailController> {
  const FarmerHistoryJobDetail({Key? key}) : super(key: key);
  //biến tạm để check UI bị đuổi

  @override
  String? get tag => Get.arguments[Arguments.tag];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.labelHistoryJobDetail),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Icon(
                      Icons.work_history_rounded,
                      size: 45,
                      color: AppColors.brown.withOpacity(0.7),
                    ),
                    Container(
                      // width: Get.width * 0.7,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: AppColors.bluePastel.withOpacity(0.4)),
                        ),
                      ),
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          Text(
                            controller.jobPost.title,
                            softWrap: true,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.headline6!.copyWith(
                              color: AppColors.brown,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            controller.isPayPerHourJob
                                ? AppStrings.payPerHour
                                : AppStrings.payPerTask,
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          Divider(
                              color: AppColors.grey.withOpacity(0.5),
                              indent: 45,
                              endIndent: 45,
                              height: 10),
                          Obx(
                            () => Container(
                              margin: const EdgeInsets.only(left: 85, top: 15),
                              child: InformationWorkCard.buildRowInfor(
                                  title: 'Trạng thái:',
                                  icon: Icons.power_settings_new,
                                  content:
                                      controller.appliedJob.value.statusString,
                                  spaceIconAndTitle: 10,
                                  contentColor:
                                      controller.appliedJob.value.statusColor),
                            ),
                          ),
                          controller.isFired
                              ? InkWell(
                                  onTap: () {
                                    BaseDialog.show(
                                          insetPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            // vertical: Get.height * 0.3,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(AppStrings.titleDetails,
                                                    style: Get
                                                        .textTheme.headline4!
                                                        .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                    )),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                CardField(
                                                  icon: Icons
                                                      .info_outline_rounded,
                                                  title: AppStrings.titleReason,
                                                  data:
                                                      controller.firedReason ??
                                                          'Không có lý do',
                                                  iconAndTitleSpace:
                                                      Get.width * 0.03,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                    //hiện pop up lý do bị đuổi
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Xem lý do ?",
                                      style: TextStyle(
                                        shadows: const [
                                          Shadow(
                                              color: Colors.red,
                                              offset: Offset(0, -5))
                                        ],
                                        fontSize: Get.textScaleFactor * 15,
                                        color: Colors.transparent,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.errorColor,
                                        decorationThickness: 2,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => LandOwnerCard(
                  name: controller.jobPost.publishedName ?? 'Chủ vườn',
                  address: controller.jobPost.address ?? 'Không có địa chỉ',
                  isBookmark: controller.isBookmark.value,
                  bookmark: controller.onBookmark,
                  report: controller.onReport,
                  feedback: controller.onFeedback,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              InformationWorkCard(
                  startDate: controller.jobPost.jobStartDate,
                  isPayPerHourJob: controller.isPayPerHourJob,
                  endDate: controller.jobPost.jobEndDate),
              const SizedBox(
                height: 20,
              ),
              Divider(
                  color: AppColors.grey.withOpacity(0.5),
                  indent: 45,
                  endIndent: 45),
              const SizedBox(
                height: 20,
              ),
              controller.isPayPerHourJob
                  ? Obx(() => controller.attendanceList.isEmpty
                      ? Column(
                          children: [
                            Text(
                              'Không có dữ liệu',
                              style: Get.textTheme.headline6!.copyWith(
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            const ImageIcon(AssetImage(AppAssets.emptyFolder),
                                size: 20),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.04,
                              child: Text(
                                'Báo cáo trả công ',
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.headline3!.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: Get.width * 0.75,
                              height: 300,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.grey.withOpacity(0.1),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.attendanceList.length,
                                itemBuilder: ((context, index) {
                                  int status =
                                      controller.attendanceList[index].status;
                                  return InkWell(
                                    splashColor:
                                        AppColors.primaryColor.withOpacity(0.2),
                                    onTap: () {
                                      // print('status: ${controller.attendanceList[index].reason}');
                                      if (status ==
                                              AttendanceStatus.absent.index ||
                                          status ==
                                              AttendanceStatus.dayOff.index) {
                                        CustomInformationDialog.show(
                                            title: 'Thông báo',
                                            message:
                                                'Bạn không tham gia công việc ngày ${Utils.formatddMMyyyy(controller.attendanceList[index].date)}');
                                        return;
                                      }
                                      if (status ==
                                          AttendanceStatus.fired.index) {
                                        BaseDialog.show(
                                          insetPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            // vertical: Get.height * 0.3,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(AppStrings.titleDetails,
                                                    style: Get
                                                        .textTheme.headline4!
                                                        .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                    )),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                CardField(
                                                  icon: Icons
                                                      .info_outline_rounded,
                                                  title: AppStrings.titleReason,
                                                  data:
                                                      controller.firedReason ??
                                                          'Không có lý do',
                                                  iconAndTitleSpace:
                                                      Get.width * 0.03,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      FarmerAttendanceDetailDialog.show(
                                        context,
                                        controller.getAttentdance(
                                            controller.attendanceList[index]),
                                        controller.jobPost.title,
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            Utils.formatddMMyyyy(controller
                                                .attendanceList[index].date),
                                          ),
                                          Text(
                                            controller.attendanceList[index]
                                                .statusString,
                                            style: TextStyle(
                                                color: controller
                                                    .attendanceList[index]
                                                    .statusColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ))
                  : Obx(
                      () => controller.attendanceList.isEmpty
                          ? Column(
                              children: [
                                Text(
                                  'Không có dữ liệu',
                                  style: Get.textTheme.headline6!.copyWith(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                const ImageIcon(
                                    AssetImage(AppAssets.emptyFolder),
                                    size: 20),
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  width: Get.width * 0.90,
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      Text(AppStrings.titleConfirmSignature,
                                          style: Get.textTheme.headline4),
                                      SizedBox(
                                        height: Get.height * 0.03,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(25),
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // image: DecorationImage(
                                          //     image:
                                          //     // Image.network(controller
                                          //     //     .attendanceList
                                          //     //     .first
                                          //     //     .signature!)

                                          //      NetworkImage(controller
                                          //         .attendanceList
                                          //         .first
                                          //         .signature!
                                          //   )
                                          //   ),
                                        ),
                                        child: Image.network(
                                          controller
                                              .attendanceList.first.signature!,
                                          // width: ,
                                          // height: 50,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.03,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                    ),
              Obx(
                () => controller.attendanceList.isEmpty
                    ? const SizedBox()
                    : Container(
                        width: Get.width * 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tổng tiền:',
                              style: Get.textTheme.bodyText1!.copyWith(
                                  color: Colors.transparent,
                                  fontSize: 20,
                                  shadows: const [
                                    Shadow(
                                        color: AppColors.primaryColor,
                                        offset: Offset(0, -5))
                                  ],
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primaryColor,
                                  decorationThickness: 1),
                            ),
                            Text(
                                Utils.vietnameseCurrencyFormat
                                    .format(controller.totalSalary.value),
                                style: Get.textTheme.bodyText1!.copyWith(
                                  fontSize: 18,
                                )),
                          ],
                        ),
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
