import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';

class Avatar extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  const Avatar({Key? key, this.imageUrl, this.width = 50, this.height = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: imageUrl == null
            ? Ink.image(
                image: const AssetImage(AppAssets.tempAvatar),
                fit: BoxFit.cover,
                width: width,
                height: height,
              )
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                width: width,
                height: height,
              ),
      ),
    );
  }
}
