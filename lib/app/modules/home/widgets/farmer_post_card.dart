import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
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
          elevation: 1.0,
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
                            padding: const EdgeInsets.only(bottom: 10.0),
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
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    children: [
                      //Tên bài post
                      Row(
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
                      const SizedBox(
                        height: 10,
                      ),
                      //Loại công việc
                      CardField(
                        icon: CustomIcons.briefcase_outline,
                        title: AppStrings.labelWorkType,
                        data: workType,
                        fontSize: 16.0,
                        titleFontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      CardField(
                        icon: CustomIcons.map_marker_outline,
                        title: AppStrings.labelAddress,
                        data: address,
                        fontSize: 15.0,
                        titleFontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      //khoảng cách
                      if (distance != null) ...[
                        CardField(
                          icon: Icons.map,
                          title: 'Cách bạn',
                          data: '$distance km',
                          fontSize: 16.0,
                          titleFontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                      CardField(
                        icon: CustomIcons.tree_outline,
                        title: 'Loại cây',
                        data: treeType,
                        fontSize: 16.0,
                        titleFontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      //Tiền công + loại trả lương
                      CardField(
                        icon: CustomIcons.wallet_outline,
                        title: paidType == AppStrings.payPerHour
                            ? 'Lương công'
                            : 'Lương khoán',
                        data: Utils.vietnameseCurrencyFormat.format(price),
                        fontSize: 16.0,
                        titleFontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
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
