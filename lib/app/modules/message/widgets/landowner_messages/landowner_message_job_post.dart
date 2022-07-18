import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/message/widgets/landowner_messages/landowner_message_item.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/toggle_information/toggle_information.dart';

class LandownerMessageJobPost extends StatelessWidget {
  final String tag;
  final String title;
  final List<Widget> jobMessages;

  const LandownerMessageJobPost({
    Key? key,
    required this.tag,
    required this.title,
    required this.jobMessages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleInformation(
      tagName: tag,
      title: title,
      isCustom: true,
      isOpen: true,
      headerWidth: double.infinity,
      headerBorder: const Border(
        bottom: BorderSide(
          color: AppColors.toggleBottomBorder,
          style: BorderStyle.solid,
          width: 1.0,
        ),
      ),
      headerMargin: EdgeInsets.zero,
      headerPadding:
          const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Container(
        color: Get.theme.cardColor,
        child: Column(
          children: jobMessages,
        ),
      ),
    );
  }
}
