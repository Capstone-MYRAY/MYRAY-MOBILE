import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';
import 'package:myray_mobile/app/shared/widgets/chips/work_type_chip.dart';

class FarmerPostCard extends StatelessWidget {
  final Color? backgroundColor;
  final String? statusName;
  final Color? statusColor;
  final bool? isStatus;
  final String? paidType;
  final Color? borderColor;
  final void Function()? onTap;
  final String? expiredDate;
  final bool? isExpired;
  final String title;
  final String address;
  final double price;
  final String treeType;
  final double? distance;
  final String workType;
  final String? imageUrl;

  const FarmerPostCard({
    Key? key,
    required this.title,
    required this.address,
    required this.price,
    required this.treeType,
    required this.onTap,
    required this.workType,
    this.paidType,
    this.isStatus = false,
    this.statusName = "Nổi bật",
    this.backgroundColor = AppColors.white,
    this.statusColor = AppColors.markedPostChipColor,
    this.borderColor = AppColors.white,
    this.expiredDate = "22/06/2022",
    this.isExpired = false,
    this.distance,
    this.imageUrl =
        'https://gialainews.com/wp-content/uploads/2019/06/Gia-Lai-mien-nho-Nhung-mua-lua-ray.jpg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.9, //indicate length of list
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isStatus!
                        ? Padding(
                          padding: const EdgeInsets.only(bottom:10.0),
                          child: StatusChip(
                              statusName: statusName!,
                              backgroundColor: statusColor!,
                          ),
                        )
                        : const SizedBox(
                            height: 25,
                          ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.fitHeight,
                        width: 100,
                        height: 100,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    WorkTypeChip(
                      workType: paidType,
                      borderRadiusSize: 20,
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      //Tên bài post
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 15, right: 15),
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
                                maxLines: 2,
                              ),
                            ),
                            // isStatus!
                            //     ? StatusChip(
                            //         statusName: statusName!,
                            //         backgroundColor: statusColor!)
                            //     : const SizedBox(
                            //         width: 1,
                            //       )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //Loại công việc
                      Padding(
                        padding: const EdgeInsets.only(top: 3, left: 15),
                        child: Row(
                          children: [
                            const Icon(Icons.work_outline, size: 20),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('${AppStrings.labelWorkType}:',
                                style: Get.textTheme.bodyText2!.copyWith(
                                    fontSize: Get.textScaleFactor * 15,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                workType,
                                style: Get.textTheme.bodyText2!.copyWith(
                                    fontSize: Get.textScaleFactor * 15),
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

                      //Địa chỉ
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            const Icon(CustomIcons.map_marker_outline,
                                size: 20),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('Địa chỉ:',
                                style: Get.textTheme.bodyText2!.copyWith(
                                    fontSize: Get.textScaleFactor * 15,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                address,
                                style: Get.textTheme.bodyText2!.copyWith(
                                    fontSize: Get.textScaleFactor * 15),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                maxLines: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.only(left: 15, right: 15),
                      //   child: Stack(
                      //     children: [
                      //       const Icon(CustomIcons.map_marker_outline,
                      //           size: 20),
                      //       Padding(
                      //         padding: EdgeInsets.only(left: 30),
                      //         child: SizedBox(
                      //           width: Get.width * 0.65,
                      //           child: Text.rich(
                      //             TextSpan(
                      //               text: address,
                      //             ),
                      //             style: Get.textTheme.bodyText2!.copyWith(
                      //                 fontSize: Get.textScaleFactor * 15),
                      //             softWrap: true,
                      //             overflow: TextOverflow.ellipsis,
                      //             textAlign: TextAlign.left,
                      //             maxLines: 3,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      //khoảng cách
                      distance != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  const Icon(Icons.map, size: 20),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text('Cách bạn:',
                                      style: Get.textTheme.bodyText2!.copyWith(
                                          fontSize: Get.textScaleFactor * 15,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      '$distance km',
                                      style: Get.textTheme.bodyText2!.copyWith(
                                          fontSize: Get.textScaleFactor * 15),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      maxLines: 10,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      //Ngày hết hạn
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     workType != null
                      //         ? Padding(
                      //             padding: const EdgeInsets.only(top: 12, left: 15),
                      //             child: WorkTypeChip(
                      //               workType: workType,
                      //               borderRadiusSize: 20,
                      //             ))
                      //         : const SizedBox(
                      //             width: 1,
                      //           ),
                      //   ],
                      // ),
                      distance != null
                          ? const SizedBox(
                              height: 10,
                            )
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(CustomIcons.tree_outline, size: 20),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('Loại cây:',
                                style: Get.textTheme.bodyText2!.copyWith(
                                    fontSize: Get.textScaleFactor * 15,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                treeType,
                                style: Get.textTheme.bodyText2!.copyWith(
                                    fontSize: Get.textScaleFactor * 15),
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
                      //Tiền công + loại trả lương
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(CustomIcons.wallet_outline, size: 20),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    paidType == AppStrings.payPerHour
                                        ? 'Lương công: '
                                        : 'Lương khoán: ',
                                    style: Get.textTheme.bodyText2!.copyWith(
                                        fontSize: Get.textScaleFactor * 15,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  Utils.vietnameseCurrencyFormat.format(price),
                                  style: Get.textTheme.bodyText2!.copyWith(
                                      fontSize: Get.textScaleFactor * 15),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  maxLines: 10,
                                ),
                              ],
                            ),
                            // Text(
                            //   paidType!,
                            //   style: Get.textTheme.bodyText2!.copyWith(
                            //     fontSize: Get.textScaleFactor * 15,
                            //     color: AppColors.primaryColor,
                            //     fontWeight: FontWeight.w600,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
