import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class MyDateRangePicker {
  static Future<DateTimeRange?> show({
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    DateTimeRange? initDateRange,
  }) async {
    return await showDateRangePicker(
      context: Get.context!,
      firstDate: firstDate,
      currentDate: currentDate,
      initialDateRange: initDateRange,
      lastDate: lastDate,
      confirmText: 'Chọn',
      cancelText: 'Đóng',
      locale: const Locale('vi', 'VN'),
      builder: (ctx, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primaryColor, //header background color
            onPrimary: AppColors.white, //header text color
            onSurface: AppColors.black, //body text color
          ),
          textTheme: Get.textTheme,
        ),
        child: child!,
      ),
    );
  }
}
