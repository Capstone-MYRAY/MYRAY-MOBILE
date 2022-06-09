class Utils {
  Utils._();

  static bool isEmpty(value) {
    return value == null || value.isEmpty;
  }

  static final vietnamesePhone = RegExp(
    '(84|0[3|5|7|8|9])+([0-9]{8})\b',
    caseSensitive: false,
  );

  static bool equalsIgnoreCase(String s1, String s2) {
    return s1.toLowerCase() == s2.toLowerCase();
  }
}
