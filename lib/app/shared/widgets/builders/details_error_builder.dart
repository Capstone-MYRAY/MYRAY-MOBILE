import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class DetailsErrorBuilder extends StatelessWidget {
  const DetailsErrorBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 50.0,
            color: AppColors.errorColor,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Đã có lỗi xảy ra',
            style: Get.textTheme.headline6!.copyWith(
              color: AppColors.errorColor,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
