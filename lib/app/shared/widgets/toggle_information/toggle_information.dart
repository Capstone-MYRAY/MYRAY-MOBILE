import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/toggle_information/toggle_header.dart';

class ToggleInformation extends GetView<ToggleController> {
  final String tagName;
  final String title;
  final Widget child;
  final bool isOpen;
  final bool isCustom;
  final double? headerWidth;
  final EdgeInsetsGeometry? headerMargin;
  final EdgeInsetsGeometry? headerPadding;
  final BorderRadiusGeometry? headerBorderRadius;
  final BoxBorder? headerBorder;

  ToggleInformation({
    Key? key,
    required this.tagName,
    required this.title,
    required this.child,
    this.isOpen = false,
    this.isCustom = false,
    this.headerWidth,
    this.headerMargin,
    this.headerPadding,
    this.headerBorderRadius,
    this.headerBorder,
  }) : super(key: key) {
    Get.put(ToggleController(), tag: tagName);
  }

  @override
  String? get tag => tagName;

  @override
  Widget build(BuildContext context) {
    controller.isOpen.value = isOpen;
    return ObxValue<RxBool>(
        (isOpen) => _buildContent(isOpen.value), controller.isOpen);
  }

  _buildContent(bool isOpen) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ToggleHeader(
          title: title,
          onTap: () => controller.toggle(),
          isOpen: isOpen,
          width: headerWidth ?? Get.width * 0.9,
          margin: headerMargin,
          padding: headerPadding,
          borderRadius: headerBorderRadius,
          border: headerBorder,
        ),
        if (isOpen && !isCustom) _buildNormal(),
        if (isOpen && isCustom) child,
      ],
    );
  }

  _buildNormal() {
    return MyCard(
      margin: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Get.textTheme.headline6,
          ),
          const SizedBox(height: 8.0),
          child,
        ],
      ),
    );
  }
}
