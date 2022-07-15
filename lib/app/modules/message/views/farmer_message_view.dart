import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/message/controllers/farmer_message_controller.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';

class FarmerMessageView extends StatelessWidget {
  const FarmerMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MessageView'),
        centerTitle: true,
      ),
      body: GetBuilder<FarmerMessageController>(
        builder: (controller) {
          return Center(
            child: FilledButton(
              title: 'Go to chat screen post 1036',
              onPressed: () => controller.navigateToChatScreen(33, 1036),
            ),
          );
        },
      ),
    );
  }
}
