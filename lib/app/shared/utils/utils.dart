import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

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

  static final vietnamesePhone = RegExp(
    r'(\+84|84)+([0-9]{9})|(0[3|5|7|8|9])+([0-9]{8})\b',
    caseSensitive: false,
  );

  static final isAlphabet = RegExp(r'[a-zA-z]');

  static final isNumber = RegExp(r'[0-9]');
}
