import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';

class BookmarkCard extends StatelessWidget {
  final String? avatar;
  final String? fullName;
  final void Function() unBookmark;
  final void Function()? onTap;
  final double _imageSize = Get.width * 0.2;

  BookmarkCard({
    Key? key,
    this.avatar,
    this.fullName,
    this.onTap,
    required this.unBookmark
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
          child: Container(
        padding: EdgeInsets.only(
            left: Get.width * 0.03,
            top: Get.width * 0.03,
            bottom: Get.width * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildAvatarPlaceHolder(),
                SizedBox(width: Get.width * 0.05),
                Text(
                  '$fullName',
                  style: Get.textTheme.bodyMedium,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(right: Get.width * 0.05),
              child: IconButton(
                  onPressed: unBookmark,
                  icon: Icon(
                    CustomIcons.heart,
                    color: Colors.red,
                    size: Get.textScaleFactor * 30,
                  )),
            ),
          ],
        ),
      )),
    );
  }

  _getImage() {
    return avatar == null
        ? const AssetImage(AppAssets.tempAvatar)
        : NetworkImage(avatar!);
  }

  Widget _buildAvatarPlaceHolder() {
    return Container(
      width: _imageSize,
      height: _imageSize,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: _imageSize,
        backgroundColor: Colors.transparent,
        backgroundImage: _getImage(),
      ),
    );
  }
}
