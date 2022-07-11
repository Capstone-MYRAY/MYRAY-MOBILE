import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';

class RatingStar extends StatelessWidget {
  final int itemCount;
  final double itemSize;
  final double rating;
  final Widget full;
  final Widget empty;
  final Widget half;
  final EdgeInsetsGeometry padding;

  const RatingStar({
    Key? key,
    this.itemCount = 5,
    this.rating = 5,
    this.itemSize = 24.0,
    this.padding = EdgeInsets.zero,
    this.full = const Icon(
      CustomIcons.star,
      color: AppColors.starColor,
    ),
    this.empty = const Icon(
      CustomIcons.star_outline,
      color: AppColors.starColor,
      size: 22.0,
    ),
    this.half = const Icon(
      CustomIcons.star_half,
      color: AppColors.starColor,
      size: 22.0,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _items,
      ),
    );
  }

  List<Widget> get _items {
    return List.generate(itemCount, (index) => _buildItem(index));
  }

  Widget _buildItem(int index) {
    Widget child;
    if (index >= rating) {
      child = empty;
    } else {
      if (index + 1 > rating) {
        child = half;
      } else {
        child = full;
      }
    }

    return Padding(
      padding: padding,
      child: SizedBox(
        width: itemSize,
        height: itemSize,
        child: child,
      ),
    );
  }
}
