import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/message/controllers/p2p_message_controller.dart';
import 'package:myray_mobile/app/modules/message/widgets/new_message/new_message.dart';
import 'package:myray_mobile/app/modules/message/widgets/p2p_messages.dart';

class P2PMessageView extends StatelessWidget {
  const P2PMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          GetBuilder<P2PMessageController>(builder: (controller) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: P2PMessages(messages: controller.messages),
              ),
            );
          }),
          NewMessage(),
        ],
      ),
    );
  }
}
