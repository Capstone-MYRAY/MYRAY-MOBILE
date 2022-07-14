import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/message/new_message_request.dart';
import 'package:myray_mobile/app/data/providers/signalR_provider.dart';
import 'package:myray_mobile/app/modules/message/controllers/p2p_message_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:signalr_netcore/hub_connection.dart';

class NewMessageController extends GetxController {
  final fromId = Get.arguments[Arguments.from];
  final toId = Get.arguments[Arguments.to];
  final jobPostId = Get.arguments[Arguments.jobPostId];
  late P2PMessageController _p2pMessageController;

  late TextEditingController messageController;
  var isDisplaySendButton = false.obs;

  @override
  void onInit() {
    messageController = TextEditingController();
    _p2pMessageController = Get.find<P2PMessageController>();
    super.onInit();
  }

  sendMessage() async {
    final msg = messageController.text.trim();
    final message = NewMessageRequest(
      fromId: fromId,
      toId: toId,
      jobPostId: jobPostId,
      message: msg,
    );

    if (SignalRProvider.instance.hubConnection?.state ==
        HubConnectionState.Connected) {
      try {
        //TODO: invoke send message (chathub)
        // await SignalRProvider.instance.hubConnection
        //     ?.invoke('SendMessage', args: [message]);

        _p2pMessageController.addNewMessage({
          'content': msg,
          'isMe': true,
          'avatar': AppAssets.tempAvatar,
        });
        messageController.clear();
      } catch (e) {
        print('Send msg error: ${e.toString()}');
      }
    }
  }

  void onMessageChange(String? value) {
    if (Utils.isEmpty(value)) {
      isDisplaySendButton.value = false;
    } else {
      isDisplaySendButton.value = true;
    }
  }
}
