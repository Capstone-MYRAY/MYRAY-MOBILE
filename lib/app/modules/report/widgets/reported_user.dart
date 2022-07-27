import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/widgets/custom_circle_avatar.dart';

class ReportedUser extends StatelessWidget {
  final String fullName;
  final String phone;
  final String? avatar;
  final double? radius;

  const ReportedUser({
    Key? key,
    required this.fullName,
    required this.phone,
    this.avatar,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCircleAvatar(
          url: avatar,
          radius: radius ?? 24.0,
        ),
        const SizedBox(height: 8.0),
        Text(
          fullName,
          style: Get.textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4.0),
        Text(
          phone,
          style: Get.textTheme.caption,
        ),
      ],
    );
  }
}
