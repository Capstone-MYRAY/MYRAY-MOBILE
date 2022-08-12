import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/message/controllers/p2p_message_controller.dart';
import 'package:myray_mobile/app/modules/message/widgets/new_message/new_message.dart';
import 'package:myray_mobile/app/modules/message/widgets/p2p_messages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/custom_circle_avatar.dart';

class P2PMessageView extends GetView<P2PMessageController> {
  const P2PMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back),
            ),
            const SizedBox(width: 8.0),
            CustomCircleAvatar(
              url: controller.toAvatar,
              radius: 18,
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.toName,
                    style: Get.textTheme.headline6,
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Công việc: ${controller.jobTitle}',
                    style: Get.textTheme.caption!.copyWith(
                      fontSize: 11 * Get.textScaleFactor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: controller.getMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyLoadingBuilder();
          }

          if (snapshot.hasError) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error,
                    size: 50.0,
                    color: AppColors.errorColor,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Đã có lỗi xảy ra',
                    style: Get.textTheme.headline6!.copyWith(
                      color: AppColors.errorColor,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              GetBuilder<P2PMessageController>(builder: (controller) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: P2PMessages(
                      messages: controller.messages,
                      toAvatar: controller.toAvatar,
                    ),
                  ),
                );
              }),
              const NewMessage(),
            ],
          );
        },
      ),
    );
  }
}
