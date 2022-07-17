import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/message/widgets/landowner_messages/landowner_message_item.dart';
import 'package:myray_mobile/app/shared/widgets/toggle_information/toggle_information.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class LandownerMessageList extends StatelessWidget {
  const LandownerMessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ToggleInformation(
          tagName: 'JobName 1',
          title: 'JobName 1',
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
              children: [
                LandownerMessageItem(
                  name: 'Nguyễn Hoàng Trúc Lan',
                  message: 'This is message.',
                  isRead: false,
                  onTap: () {},
                ),
                LandownerMessageItem(
                  name: 'Nguyễn Hoàng Long',
                  message: 'This is message.',
                  isRead: false,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        ToggleInformation(
          tagName: 'JobName 2',
          title: 'JobName 2',
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
              children: [
                LandownerMessageItem(
                  name: 'Nguyễn Lan Anh',
                  message: 'This is message.',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
