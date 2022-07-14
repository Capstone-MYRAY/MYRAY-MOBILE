import 'package:get/get.dart';
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

  addNewMessage(message) {
    messages.add(message);
    update();
  }
}
