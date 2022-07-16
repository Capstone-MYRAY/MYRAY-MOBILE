import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/message/controllers/landowner_message_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
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
          return Center(
            child: FilledButton(
              title: 'Go to chat screen post 1036',
              onPressed: () => controller.navigateToChatScreen(35, 1036),
            ),
          );
        },
      ),
    );
  }
}
