import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';

class LandownerAvatar extends StatelessWidget {
  final String fullName;
  final String? avatar;
  final void Function()? onButtonClick;

  LandownerAvatar({
    Key? key,
    required this.fullName,
    this.avatar,
    this.onButtonClick,
  }) : super(key: key);

  final double _imageSize = Get.width * 0.3;

  _getImage() {
    return avatar == null
        ? const AssetImage(AppAssets.tempAvatar)
        : NetworkImage(avatar!);
  }

  Widget _buildAvatarPlaceholder() {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 10.0),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: _imageSize * 2 / 3),
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              top: _imageSize / 3 + 16,
              bottom: 24,
              right: 24,
              left: 24,
            ),
            width: Get.width * 0.9,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  fullName,
                  style: Get.textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                FilledButton(
                  minWidth: CommonConstants.buttonWidthSmall,
                  title: AppStrings.titleViewProfile,
                  onPressed: onButtonClick,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: _buildAvatarPlaceholder(),
            ),
          ),
        ],
      ),
    );
  }
}
