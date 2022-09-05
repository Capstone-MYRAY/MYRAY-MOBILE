import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';

class HistoryJobCard extends StatelessWidget {
  final String title;
  final String nameOnwner;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final int? numOfDayOff;
  final String statusName;
  final Color statusColor;
  final void Function() onTap;
  const HistoryJobCard(
      {Key? key,
      required this.title,
      required this.nameOnwner,
      required this.type,
      required this.startDate,
      required this.endDate,
      required this.statusName,
      required this.statusColor,
      required this.onTap,
      this.numOfDayOff})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(title,
                            style: Get.textTheme.headline4?.copyWith(
                                color: AppColors.brown,),
                            softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ]),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CardField(
                  icon: CustomIcons.person,
                  title: AppStrings.landowner,
                  data: nameOnwner,
                  iconAndTitleSpace: Get.width * 0.03,
                ),
                SizedBox(
                  height: Get.height * 0.010,
                ),
                 CardField(
                  icon: CustomIcons.box,
                  title: AppStrings.labelWorkType,
                  data: type,
                  iconAndTitleSpace: Get.width * 0.03,
                ),
                SizedBox(
                  height: Get.height * 0.010,
                ),
                 CardField(
                  icon: CustomIcons.calendar_star,
                  title: "Ngày bắt đầu",
                  data: Utils.formatddMMyyyy(startDate),
                  iconAndTitleSpace: Get.width * 0.03,
                ),
                SizedBox(
                  height: Get.height * 0.010,
                ),
                 CardField(
                  icon: CustomIcons.calendar_check,
                  title: "Ngày kết thúc",
                  data: Utils.formatddMMyyyy(endDate),
                  iconAndTitleSpace: Get.width * 0.03,
                ),
                SizedBox(
                  height: Get.height * 0.010,
                ),
                SizedBox(
                  height: Get.height * 0.010,
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(children: [
                    const Icon(CustomIcons.work_history_outline, size: 20),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Trạng thái:",
                      style: Get.textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    StatusChip(
                      statusName: statusName,
                      backgroundColor: statusColor,
                      foregroundColor: Colors.white,
                    ),
                  ]),
                ),
                SizedBox(
                  height: Get.height * 0.010,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
