import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/day_off/day_off.dart';
import 'package:myray_mobile/app/modules/applied_job/controllers/day_off_controller.dart';
import 'package:myray_mobile/app/modules/applied_job/widgets/farmer_onLeave/farmer_onLeave_card.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class FarmerOnLeaveList extends StatelessWidget {
  const FarmerOnLeaveList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DayOffController>(
      builder: (controller) {
        return FutureBuilder(
            future: controller.getDayOffList(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const MyLoadingBuilder();
              }
              return Obx(() => LazyLoadingList(
                    onEndOfPage: controller.getDayOffList,
                    onRefresh: controller.onRefresh,
                    isLoading: controller.isLoading.value,
                    itemCount: controller.dayOffList.isEmpty
                        ? 1
                        : controller.dayOffList.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data == null ||
                          controller.dayOffList.isEmpty) {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(vertical: Get.height * 0.3),
                          child: Center(
                            child: Column(
                              children: [
                                Text("Không có đơn xin nghỉ nào.",
                                    style: Get.textTheme.bodyLarge!.copyWith(
                                      color: AppColors.grey,
                                      fontSize: Get.textScaleFactor * 20,
                                    ),
                                    textAlign: TextAlign.center),
                                const SizedBox(height: 10),
                                const ImageIcon(AssetImage(AppAssets.noForm),
                                    size: 30, color: AppColors.grey),
                              ],
                            ),
                          ),
                        );
                      }
                      DayOff dayOff = controller.dayOffList[index];
                      return Container(
                        padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
                        child: FarmerOnLeaveCard(
                            job: dayOff.appliedJobTitle,
                            submitDate: dayOff.createdDate ?? DateTime.now(),
                            dayOffDate: dayOff.date,
                            numOfOnleaveDays: 3,
                            reason: dayOff.reason ?? 'Không có lý do',
                            onTap: () {
                              Get.defaultDialog(
                                  title: 'Chi tiết',
                                  titlePadding: const EdgeInsets.only(top: 20),
                                  contentPadding: const EdgeInsets.all(20),
                                  titleStyle: Get.textTheme.headline3,
                                  radius: 9,
                                  content: SingleChildScrollView(
                                    reverse: true,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_today_outlined,
                                              size: 17,
                                              color: AppColors.black,
                                            ),
                                            SizedBox(width: Get.height * 0.01),
                                            Text(
                                              'Ngày nộp đơn:',
                                              style: Get.textTheme.labelMedium!
                                                  .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    Get.textScaleFactor * 17,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.01),
                                        Row(
                                          children: [
                                            SizedBox(width: Get.width * 0.07),
                                            Expanded(
                                              child: Text(
                                                dayOff.createdDate != null
                                                    ? Utils.formatddMMyyyy(
                                                        dayOff.createdDate!)
                                                    : 'Đang cập nhật',
                                                style: Get.textTheme.bodyText2!
                                                    .copyWith(
                                                        fontSize:
                                                            Get.textScaleFactor *
                                                                16),
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                maxLines: 5,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.date_range_outlined,
                                              size: 17,
                                              color: AppColors.black,
                                            ),
                                            SizedBox(width: Get.height * 0.01),
                                            Text(
                                              'Ngày nghỉ:',
                                              style: Get.textTheme.labelMedium!
                                                  .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    Get.textScaleFactor * 17,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.01),
                                        Row(
                                          children: [
                                            SizedBox(width: Get.width * 0.07),
                                            Expanded(
                                              child: Text(
                                                Utils.formatddMMyyyy(
                                                    dayOff.date),
                                                style: Get.textTheme.bodyText2!
                                                    .copyWith(
                                                        fontSize:
                                                            Get.textScaleFactor *
                                                                16),
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                maxLines: 5,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.content_copy_rounded,
                                              size: 17,
                                              color: AppColors.black,
                                            ),
                                            SizedBox(width: Get.height * 0.01),
                                            Text(
                                              'Lý do nghỉ:',
                                              style: Get.textTheme.labelMedium!
                                                  .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    Get.textScaleFactor * 17,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.01),
                                        Row(
                                          children: [
                                            SizedBox(width: Get.width * 0.07),
                                            Expanded(
                                              child: Text(
                                                dayOff.reason ??
                                                    'Không có lý do',
                                                style: Get.textTheme.bodyText2!
                                                    .copyWith(
                                                        fontSize:
                                                            Get.textScaleFactor *
                                                                16),
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                maxLines: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02),
                                        CustomTextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            title: 'Đóng',
                                            border: Border.all(
                                              color: AppColors.primaryColor,
                                            ),
                                            foreground: AppColors.primaryColor,
                                            background: AppColors.white,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Get.width * 0.08,
                                                vertical: 9)),
                                      ],
                                    ),
                                  ));
                            }),
                      );
                    },
                  ));
            }));
      },
    );
  }
}
