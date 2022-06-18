import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/filled_button.dart';

class FarmerAvatar extends StatelessWidget {
  final String? avatar;
  final String fullName;
  final int? point;
  final void Function()? onButtonClick;

  FarmerAvatar({
    Key? key,
    this.avatar,
    required this.fullName,
    this.point,
    this.onButtonClick
  }) : super(key: key);

  final double _imageSize = Get.width * 0.3;

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

  @override
  Widget build(BuildContext context) {

    return Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(top: 10.0),
        child: Stack(children: [
          Container(
            margin: EdgeInsets.only(top: _imageSize * 2 / 3),
            alignment: Alignment.center,
            width: Get.width * 0.9,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: _imageSize / 2.5),
                Text(
                  fullName,
                  style: Get.textTheme.headline4,                
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const[
                     Icon(CustomIcons.star, size: 15),
                     SizedBox(width: 5.0),
                     Text(
                    "1000",// chưa load dữ liệu lên được, vì có thể thay đổi nên tính sau
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'điểm thưởng',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 11.0),
                  child: FilledButton(
                    title: AppStrings.titleViewProfile,
                    minWidth: CommonConstants.buttonWidthSmall,
                    onPressed: onButtonClick
                  ),
                ),               
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: _buildAvatarPlaceHolder(),
            ),
          )
        ]));
  }
}
