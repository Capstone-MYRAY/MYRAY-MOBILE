import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDatePicker {
  static Future<DateTime?> show({
    DateTime? initDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    return showDatePicker(
      context: Get.context!,
      initialDate: initDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      locale: const Locale('vi'),
    );
  }
}
