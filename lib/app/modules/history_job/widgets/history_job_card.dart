import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
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
                                color: AppColors.brown,
                                fontSize: Get.textScaleFactor * 25),
                            softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ]),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(children: [
                    const Icon(CustomIcons.person, size: 20),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Chủ rẫy:",
                      style: Get.textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: Get.textScaleFactor * 15,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      nameOnwner,
                      style: Get.textTheme.bodyText2!.copyWith(
                        fontSize: Get.textScaleFactor * 15,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      maxLines: 5,
                    ),
                  ]),
                ),
                SizedBox(
                  height: Get.height * 0.010,
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(children: [
                    const Icon(CustomIcons.box, size: 20),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Loại công việc:",
                      style: Get.textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: Get.textScaleFactor * 15,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.040,
                    ),
                    Text(
                      type,
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
                  padding: const EdgeInsets.all(0),
                  child: Row(children: [
                    const Icon(CustomIcons.calendar_star, size: 20),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Ngày bắt đầu:",
                      style: Get.textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: Get.textScaleFactor * 15,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(startDate),
                      style: Get.textTheme.bodyText2!.copyWith(
                        fontSize: Get.textScaleFactor * 15,
                      ),
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
                  padding: const EdgeInsets.all(0),
                  child: Row(children: [
                    const Icon(CustomIcons.calendar_check, size: 20),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Ngày kết thúc:",
                      style: Get.textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: Get.textScaleFactor * 15,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.040,
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(endDate),
                      style: Get.textTheme.bodyText2!.copyWith(
                        fontSize: Get.textScaleFactor * 15,
                      ),
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
                  padding: const EdgeInsets.all(0),
                  child: Row(children: [
                    const Icon(CustomIcons.work_history_outline, size: 20),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                     "Trạng thái:",
                      style: Get.textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: Get.textScaleFactor * 15,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    StatusChip(
                      statusName:
                          statusName,
                      backgroundColor:
                          statusColor,
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
