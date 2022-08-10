import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/message/controllers/farmer_message_controller.dart';
import 'package:myray_mobile/app/modules/message/widgets/farmer_messages/farmer_message_list.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';

class FarmerMessageView extends StatelessWidget {
  const FarmerMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.message),
        centerTitle: true,
      ),
      body: GetBuilder<FarmerMessageController>(
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

              return FarmerMessageList(
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
