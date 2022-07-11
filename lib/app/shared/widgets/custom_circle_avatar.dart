import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String? url;
  final double? radius;
  const CustomCircleAvatar({
    Key? key,
    this.url,
    this.radius,
  }) : super(key: key);

  ImageProvider get _avatar => url == null
      ? const AssetImage(AppAssets.tempAvatar) as ImageProvider
      : NetworkImage(url!);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.transparent,
      backgroundImage: _avatar,
    );
  }
}
