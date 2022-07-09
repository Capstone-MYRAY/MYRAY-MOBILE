import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/landowner_job_post_details/toggle_header.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';

class ToggleInformation extends GetView<ToggleController> {
  final String tagName;
  final String title;
  final Widget child;
  final bool isOpen;
  const ToggleInformation({
    Key? key,
    required this.tagName,
    required this.title,
    required this.child,
    this.isOpen = false,
  }) : super(key: key);

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
      children: [
        ToggleHeader(
          title: title,
          onTap: () => controller.toggle(),
          isOpen: isOpen,
        ),
        if (isOpen)
          MyCard(
            margin: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Get.textTheme.headline6,
                ),
                const SizedBox(height: 8.0),
                child,
              ],
            ),
          ),
      ],
    );
  }
}
