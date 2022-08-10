import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/image/hero_photo_view.dart';

class RoundImage extends StatelessWidget {
  final String? imageUrl;
  final double borderRadius;
  final double width;
  final double height;
  final BoxFit boxFit;

  const RoundImage({
    Key? key,
    this.imageUrl,
    this.borderRadius = CommonConstants.borderRadius,
    this.width = 120,
    this.height = double.infinity,
    this.boxFit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: width,
        maxHeight: height,
      ),
      child: GestureDetector(
        onTap: () => _onTap(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: imageUrl == null
              ? Image.asset(AppAssets.placeholderImage)
              : Utils.isNetworkImage(imageUrl!)
                  ? Image.network(
                      imageUrl!,
                      fit: boxFit,
                      loadingBuilder: (_, child, chunk) {
                        if (chunk != null) {
                          return Image.asset(AppAssets.placeholderImage);
                        }

                        return child;
                      },
                    )
                  : Image.file(
                      File(imageUrl!),
                      fit: boxFit,
                    ),
        ),
      ),
    );
  }

  _onTap(context) {
    if (imageUrl == null) return;
    //get tag
    String tag = imageUrl!.split('/').last;
    ImageProvider imageProvider = Utils.isNetworkImage(imageUrl!)
        ? NetworkImage(imageUrl!)
        : FileImage(File(imageUrl!)) as ImageProvider;
    Get.to(() => HeroPhotoView(imageProvider: imageProvider, tag: tag));
  }
}
