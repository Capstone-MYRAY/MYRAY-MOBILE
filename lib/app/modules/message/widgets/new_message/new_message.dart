import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/activities.dart';
import 'package:myray_mobile/app/modules/message/widgets/new_message/new_message_controller.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_icon_button.dart';

class NewMessage extends GetView<NewMessageController> {
  const NewMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        children: [
          CustomIconButton(
            icon: CustomIcons.photo,
            onTap: () => controller.sendImage(Activities.photo),
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            foregroundColor: Theme.of(context).primaryColor,
            isSplash: false,
          ),
          CustomIconButton(
            icon: CustomIcons.gallery,
            onTap: () => controller.sendImage(Activities.gallery),
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            foregroundColor: Theme.of(context).primaryColor,
            isSplash: false,
          ),
          Expanded(
            child: TextField(
              minLines: 1,
              maxLines: 100,
              controller: controller.messageController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                // suffixIcon: GestureDetector(
                //   onTap: () {
                //     print('open icon');
                //   },
                //   child: Icon(
                //     Icons.insert_emoticon,
                //     color: Theme.of(context).primaryColor,
                //     size: 24,
                //   ),
                // ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                hintText: 'Aa',
                hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 15.0,
                    ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    width: 0.0,
                    style: BorderStyle.none,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    width: 0.0,
                    style: BorderStyle.none,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    width: 0.0,
                    style: BorderStyle.none,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    width: 0.0,
                    style: BorderStyle.none,
                  ),
                ),
                fillColor: Colors.black.withOpacity(0.05),
                filled: true,
              ),
              onChanged: controller.onMessageChange,
            ),
          ),
          Obx(
            () => controller.isDisplaySendButton.value
                ? CustomIconButton(
                    icon: CustomIcons.send,
                    onTap: controller.sendMessage,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    foregroundColor: Theme.of(context).primaryColor,
                    isSplash: false,
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
