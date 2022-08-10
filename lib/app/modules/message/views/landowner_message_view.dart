import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/message/controllers/landowner_message_controller.dart';
import 'package:myray_mobile/app/modules/message/widgets/landowner_messages/landowner_message_list.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/landowner_appbar.dart';

class LandownerMessageView extends StatelessWidget {
  const LandownerMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LandownerAppbar(
        title: Text(
          AppStrings.message,
          textScaleFactor: 1,
        ),
      ),
      body: GetBuilder<LandownerMessageController>(
        builder: (controller) {
          return FutureBuilder(
            future: controller.loadInitMessages(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingBuilder();
              }

              if (controller.messages.isEmpty) {
                return const ListEmptyBuilder(onRefresh: null);
              }

              return LandownerMessageList(
                messages: controller.messages,
                onTap: controller.navigateToChatScreen,
              );
            },
          );
        },
      ),
    );
  }
}
