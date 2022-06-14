import 'package:intl/intl.dart';

class Utils {
  Utils._();

  static bool isEmpty(value) {
    return value == null || value.isEmpty;
  }

  static bool equalsIgnoreCase(String s1, String s2) {
    return s1.toLowerCase() == s2.toLowerCase();
  }

  static final vietnamesePhone = RegExp(
    r'(\+84|84)+([0-9]{9})|(0[3|5|7|8|9])+([0-9]{8})\b',
    caseSensitive: false,
  );

  static final isAlphabet = RegExp(r'[a-zA-z]');

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
}
