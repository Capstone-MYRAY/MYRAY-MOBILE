import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class Utils {
  Utils._();

  static bool isEmpty(value) {
    return value == null || value.isEmpty;
  }

  static bool equalsIgnoreCase(String s1, String s2) {
    return s1.toLowerCase() == s2.toLowerCase();
  }

  static bool equalsUtf8String(String s1, String s2) {
    List<int> encodeS1 = utf8.encode(s1);
    List<int> encodeS2 = utf8.encode(s2);
    return listEquals(encodeS1, encodeS2);
  }

  static bool isWorkingAge(String dob, String patern) {
    DateTime birthDate = DateFormat(patern).parse(dob);
    DateTime today = DateTime.now();

    DateTime workingDate = DateTime(
      birthDate.year + 15,
      birthDate.month,
      birthDate.day,
    );

    return workingDate.isBefore(today);
  }

  static String formatVietnamesePhone(String phone) {
    if (phone.startsWith('0')) {
      return '+84${phone.substring(1)}';
    } else if (phone.startsWith('84')) {
      return '+$phone';
    } else {
      return phone;
    }
  }

  static bool isNetworkImage(String path) {
    return path.contains('https') || path.contains('http');
  }

  static String formatHHmm(TimeOfDay time) {
    return time.hour.toString().padLeft(2, '0') +
        ':' +
        time.minute.toString().padLeft(2, '0');
  }

  static String formatddMMyyyy(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static toLowerCaseNonAccentVietnamese(String str) {
    str = str.toLowerCase();
    str = str.replaceAll(RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'), "a");
    str = str.replaceAll(RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'), "e");
    str = str.replaceAll(RegExp(r'ì|í|ị|ỉ|ĩ'), "i");
    str = str.replaceAll(RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'), "o");
    str = str.replaceAll(RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'), "u");
    str = str.replaceAll(RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'), "y");
    str = str.replaceAll(RegExp(r'đ'), "d");
    // Some system encode vietnamese combining accent as individual utf-8 characters
    str = str.replaceAll(RegExp(r'\u0300|\u0301|\u0303|\u0309|\u0323'), "");
    // Huyền sắc hỏi ngã nặng
    str = str.replaceAll(RegExp(r'\u02C6|\u0306|\u031B'), ""); // Â, Ê, Ă, Ơ, Ư
    return str;
  }

  static bool isInteger(String value) {
    return int.tryParse(value) != null;
  }

  static bool isDouble(String value) {
    return double.tryParse(value) != null;
  }

  static bool isPositiveInteger(String value) {
    int? number = int.tryParse(value);
    if (number == null) return false;
    if (number > 0) return true;
    return false;
  }

  static bool isPositiveRealNumber(String value) {
    double? number = double.tryParse(value);
    if (number == null) return false;
    if (number > 0) return true;
    return false;
  }

  static DateTime fromddMMyyyy(String date) {
    return DateFormat(CommonConstants.ddMMyyyy).parse(date);
  }

  static TimeOfDay fromHHmm(String time) {
    return TimeOfDay(
      hour: int.parse(time.split(":").first),
      minute: int.parse(time.split(":").last),
    );
  }

  static final vietnameseCurrencyFormat =
      NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

  static final threeDigitsFormat = NumberFormat.decimalPattern('vi_VN');

  static final vietnamesePhone = RegExp(
    r'(\+84|84)+([0-9]{9})|(0[3|5|7|8|9])+([0-9]{8})\b',
    caseSensitive: false,
  );

  static final isAlphabet = RegExp(r'[a-zA-z]');
}
