import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';
import 'package:myray_mobile/app/shared/widgets/chips/work_type_chip.dart';

class FarmerSpecialPostCard extends StatelessWidget {
  final Color? backgroundColor;
  final String? statusName;
  final Color? statusColor;
  final bool? isStatus;
  final String? workType;
  final Color? borderColor;
  final void Function()? onTap;
  final String? expiredDate;
  final bool? isExpired;
  final String title;
  final String address;
  final double price;
  final String treeType;
  final Color? statusNameColor;

  const FarmerSpecialPostCard({
    Key? key,
    required this.title,
    required this.address,
    required this.price,
    required this.treeType,
    required this.onTap,
    this.workType,
    this.isStatus = false,
    this.statusName = "Nổi bật",
    this.backgroundColor = AppColors.white,
    this.statusColor = AppColors.markedPostChipColor,
    this.borderColor = AppColors.white,
    this.expiredDate = "22/06/2022",
    this.isExpired = false,
    this.statusNameColor = AppColors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.8, //indicate length of list
        // margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor!,
            )),
        child: Card(
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 13, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: Get.textTheme.headline4,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 10,
                        ),
                      ),
                      isStatus!
                          ? StatusChip(
                              statusName: statusName!,
                              backgroundColor: statusColor!,
                              foregroundColor: statusNameColor,
                            )
                          : const SizedBox(
                              width: 1,
                            )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, left: 13, right: 15),
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
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 13),
                  child: Row(
                    children: [
                      const Icon(CustomIcons.wallet_outline, size: 20),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          Utils.vietnameseCurrencyFormat.format(price),
                          style: Get.textTheme.bodyText2!
                              .copyWith(fontSize: Get.textScaleFactor * 14),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 13),
                  child: Row(
                    children: [
                      const Icon(CustomIcons.tree_outline, size: 20),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          treeType,
                          style: Get.textTheme.bodyText2!
                              .copyWith(fontSize: Get.textScaleFactor * 14),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    workType != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 12, left: 13),
                            child: WorkTypeChip(
                              workType: workType,
                            ))
                        : const SizedBox(
                            width: 1,
                          ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 25),
                      child: Row(
                          // verticalDirection: VerticalDirection.down,
                          children: [
                            isExpired!
                                ? Text(
                                    "Đã hết hạn",
                                    style: Get.textTheme.caption!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontSize: Get.textScaleFactor * 10),
                                  )
                                : Text(
                                    "Ngày hết hạn: ${expiredDate!}",
                                    style: Get.textTheme.overline!.copyWith(
                                        fontStyle: FontStyle.italic,
                                        color: AppColors.warningColor,
                                        fontSize: Get.textScaleFactor * 10),
                                  )
                          ]),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
