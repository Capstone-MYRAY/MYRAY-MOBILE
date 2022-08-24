import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class FeedbackEmptyBuilder extends StatelessWidget {
  final void Function()? onRefresh;
  const FeedbackEmptyBuilder({
    Key? key,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Chưa có đánh giá nào',
            style: Get.textTheme.bodyMedium!.copyWith(
              color: AppColors.grey,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          const ImageIcon(AssetImage(AppAssets.feedBack),
              size: 50, color: AppColors.grey),
          FractionallySizedBox(
            widthFactor: 0.3,
            child: TextButton(
              onPressed: onRefresh,
              child: Text('Tải lại', style: Get.textTheme.headline6),
            ),
          )
        ],
      ),
    );
  }
}
