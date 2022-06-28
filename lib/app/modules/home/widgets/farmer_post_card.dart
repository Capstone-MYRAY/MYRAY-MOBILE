import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/status_chip.dart';
import 'package:myray_mobile/app/shared/widgets/work_type_chip.dart';

class FarmerPostCard extends StatelessWidget {
  final Color? backgroundColor;
  final String? statusName;
  final Color? statusColor;
  final bool? isStatus;
  final String? workType;
  final void Function()? onTap;
  final String? expiredDate;
  final bool? isExpired;
  final String title;
  final String address;
  final int price;
  final String treeType;

  const FarmerPostCard(
      {Key? key,
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
      this.expiredDate = "22/06/2022",
      this.isExpired = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.8,
        // height: Get.height * 0.20,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
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
                          backgroundColor: statusColor!)
                      : const SizedBox(
                          width: 1,
                        )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15),
              child: Row(
                children: [
                  const Icon(CustomIcons.map_marker_outline, size: 20),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      address,
                      style: Get.textTheme.bodyText2,
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
              padding: const EdgeInsets.only(top: 3, left: 15),
              child: Row(
                children: [
                  const Icon(CustomIcons.wallet_outline, size: 20),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      price.toString() + " đ/ngày",
                      style: Get.textTheme.bodyText2,
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
              padding: const EdgeInsets.only(top: 3, left: 15),
              child: Row(
                children: [
                  const Icon(CustomIcons.tree_outline, size: 20),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      treeType,
                      style: Get.textTheme.bodyText2,
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
                        padding: const EdgeInsets.only(top: 12, left: 15),
                        child: WorkTypeChip(
                          workType: workType,
                        ))
                    : const SizedBox(
                        width: 1,
                      ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                    isExpired! ? Text("Đã hết hạn") :
                    Text("Ngày hết hạn: " + expiredDate!)
                    
                  ]),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
