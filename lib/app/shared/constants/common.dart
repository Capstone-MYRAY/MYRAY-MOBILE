import 'package:get/get.dart';

class Arguments {
  static const String tag = 'tag';
  static const String item = 'item';
  static const String phone = 'phone';
  static const String action = 'action';
  static const String from = 'from';
  static const String to = 'to';
  static const String jobPostId = 'jobPostId';
  static const String conventionId = 'conventionId';
  static const String toAvatar = 'toAvatar';
  static const String toName = 'toName';
  static const String jobTitle = 'jobTitle';
  static const String isBookmarked = 'isBookmarked';
  static const String address = 'address';
  static const String laLng = 'laLng';
  static const String placeId = 'placeId';
}

class CommonConstants {
  const CommonConstants._();

  static const double elevation = 2.0;
  static const double borderRadius = 4.0;
  static const int otpNum = 6;
  static const int otpTimer = 60;
  static const int landownerRoleId = 3;
  static const int farmerRoleId = 4;
  static const int maxImage = 4;
  static double get buttonWidthSmall => Get.width * 0.3;
  static const double buttonHeight = 32.0;
  static const String appName = 'MYRAY';
  static const String ddMMyyyy = 'dd/MM/yyyy';
  static double get buttonWidthLarge => Get.width * 0.7;
  static const double buttonHeightSmall = 20;
  static const String imageDelimiter = '<|>';
}
