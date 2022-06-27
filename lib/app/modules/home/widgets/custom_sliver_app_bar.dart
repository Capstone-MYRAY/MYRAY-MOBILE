import 'package:flutter/material.dart';

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double heightOfScreen;
  final String? titleFloatingCard;

  const CustomSliverAppBarDelegate({
    required this.expandedHeight,
    required this.heightOfScreen,
    this.titleFloatingCard = "Tiêu đề bài đăng",
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var size = heightOfScreen;
    final top = expandedHeight - shrinkOffset - size / 2;

    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        buildBackground(shrinkOffset),
        Positioned(
          top: top,
          left: 20,
          right: 20,
          child: buildFloating(shrinkOffset),
        ),
        // SizedBox(height: 100,)
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

  Widget buildFloating(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Card(
          child: Row(
            children: [
              //Expanded(child: buildButton(text: 'Share', icon: Icons.share)),
              Expanded(
                child: buildButton(
                  text: titleFloatingCard!,
                ),
              ),
              // buildFloatingCard()
            ],
          ),
        ),
      );

  Widget buildButton({required String text}) => TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: 20)),
            const SizedBox(height: 100)
          ],
        ),
        onPressed: () {},
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
