import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double heightOfScreen;
  final String? titleFloatingCard;
  final bool? isChangedState;
  final bool? isExpired;
  final List<Widget> imageList;

  CustomSliverAppBarDelegate({
    required this.expandedHeight,
    required this.heightOfScreen,
    this.titleFloatingCard = "Tiêu đề bài đăng",
    this.isChangedState,
    this.isExpired = false,
    required this.imageList
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var size = heightOfScreen;
    final top = expandedHeight - shrinkOffset - size / 2;
    print("state: $isChangedState");
    return Stack(
      fit: StackFit.expand,
      // overflow: Overflow.visible,
      children: [
        // buildBackground(shrinkOffset),
        buildBackgroundSlider(shrinkOffset),
        // SizedBox(height: 100,),
        Positioned(
          top: top,
          left: 20,
          right: 20,
          child: buildFloating(shrinkOffset),
        ),
      ],
    );
  }

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildBackground(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Image.network(
          'https://gialainews.com/wp-content/uploads/2019/06/Gia-Lai-mien-nho-Nhung-mua-lua-ray.jpg',
          fit: BoxFit.cover,
        ),
      );
   Widget buildBackgroundSlider(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: ImageSlideshow(
           autoPlayInterval: CommonConstants.autoPlayIntervalTime,
           isLoop: imageList.length != 1,
           indicatorColor: AppColors.white,
          children: imageList,
        ),
   );

  Widget buildFloating(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.bottomRight,
          child: Card(
            color: AppColors.black.withOpacity(0.2),
            child: Row(
              children: [
                //Expanded(child: buildButton(text: 'Share', icon: Icons.share)),
                Expanded(
                  child: Column(children: [
                    buildButton(
                      text: titleFloatingCard!,
                      // isChangedState: isChangedState!,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildButton({required String text}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: Get.height * 0.1,
          child: Column(children: [
            Container(
              margin: text.length > 40
                  ? const EdgeInsets.only(top: 5)
                  : const EdgeInsets.only(top: 30),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: Get.textScaleFactor * 22,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500),
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.justify,
              ),
            ),
            // SizedBox(height: 10),
          ]),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const Icon(
        //       Icons.history,
        //       size: 15,
        //       color: AppColors.primaryColor,
        //     ),
        //     const SizedBox(
        //       width: 10,
        //     ),
        //     Text(
        //       isChangedState ? 'Đã ứng tuyển' : "Ngày hết hạn",
        //       style: Get.textTheme.caption!.copyWith(
        //         color: AppColors.primaryColor,
        //         fontStyle: FontStyle.italic,
        //         fontWeight: FontWeight.bold
        //       ),
        //     )
        //   ],
        // ),
        // const SizedBox(height: 10),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
