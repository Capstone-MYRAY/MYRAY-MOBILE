import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/rating_star.dart';

class FeedbackFarmerCard extends StatelessWidget {
  final DateTime createdDate;
  final double rating;
  final String content;
  final bool canUpdate;
  final void Function()? onEditPressed;

  const FeedbackFarmerCard({
    Key? key,
    required this.createdDate,
    required this.rating,
    required this.content,
    this.onEditPressed,
    this.canUpdate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 32.0,
        right: 32,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Ngày tạo: ${Utils.formatddMMyyyy(createdDate)}',
              style: Get.textTheme.caption!.copyWith(
                fontSize: 12 * Get.textScaleFactor,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Thông tin đánh giá',
              style: Get.textTheme.headline6,
            ),
          ),
          const SizedBox(height: 8.0),
          RatingStar(
            rating: rating,
            itemSize: 24.0,
          ),
          const SizedBox(height: 8.0),
          CardField(
            title: 'Chi tiết đánh giá',
            icon: CustomIcons.content_paste,
            data: content.isEmpty ? 'N/A' : content,
          ),
          if (canUpdate)
            TextButton(
              onPressed: onEditPressed,
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: const Text(AppStrings.titleEdit),
            ),
        ],
      ),
    );
  }
}
