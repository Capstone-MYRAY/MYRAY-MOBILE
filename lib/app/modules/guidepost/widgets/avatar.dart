import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';

class Avatar extends StatelessWidget {
  final String? imageUrl;
  const Avatar({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: imageUrl == null
            ? Ink.image(
                image: const AssetImage(AppAssets.tempAvatar),
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              )
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
      ),
    );
  }
}
