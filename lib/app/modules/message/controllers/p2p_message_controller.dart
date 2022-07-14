import 'package:get/get.dart';
import 'package:myray_mobile/app/data/providers/signalR_provider.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class P2PMessageController extends GetxController {
  final fromId = Get.arguments[Arguments.from];
  final toId = Get.arguments[Arguments.to];
  final jobPostId = Get.arguments[Arguments.jobPostId];

  final List messages = [
    {
      'content': 'How about 8?',
      'isMe': true,
      'avatar': AppAssets.tempAvatar,
    },
    {
      'content': 'Cool what time?',
      'isMe': false,
      'avatar': AppAssets.tempAvatar,
    },
    {
      'content': 'Wanna go out tonight',
      'isMe': true,
      'avatar': AppAssets.tempAvatar,
    },
    {
      'content': 'Hello',
      'isMe': true,
      'avatar': AppAssets.tempAvatar,
    },
  ];

  @override
  void onInit() async {
    //TODO: listen change (chathub)
    // SignalRProvider.instance.hubConnection!.on('chat', _onChatConnect);
    print('P2PMC: on chat');
    super.onInit();
  }

  void _onChatConnect(List<Object>? arguments) {
    print('Arguments: $arguments');
  }

  addNewMessage(message) {
    print('add message');
    messages.insert(0, message);
    update();
  }
}
