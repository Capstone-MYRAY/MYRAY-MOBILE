import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/message/get_message_request.dart';
import 'package:myray_mobile/app/data/models/message/message.dart';
import 'package:myray_mobile/app/data/providers/signalR_provider.dart';
import 'package:myray_mobile/app/modules/message/message_repository.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class P2PMessageController extends GetxController {
  final _messageRepository = Get.find<MessageRepository>();
  final fromId = Get.arguments[Arguments.from];
  final toId = Get.arguments[Arguments.to];
  final jobPostId = Get.arguments[Arguments.jobPostId];
  final conventionId = Get.arguments[Arguments.conventionId];
  final toAvatar = Get.arguments[Arguments.toAvatar];

  final List<Message> messages = [];

  @override
  void onInit() {
    SignalRProvider.instance.hubConnection!.on('chat', _onChatConnect);
    super.onInit();
  }

  @override
  void onClose() {
    SignalRProvider.instance.hubConnection!.off('chat', method: _onChatConnect);
    super.onClose();
  }

  Future<void> getMessages() async {
    final data = GetMessageRequest(conventionId: conventionId);
    final messageList = await _messageRepository.getList(data);
    messages.addAll(messageList);
    update();
  }

  void _onChatConnect(List<Object>? arguments) {
    print('Arguments: $arguments');
    if (arguments != null) {
      print(arguments[1]);
      final msg = arguments[1] as Map<String, dynamic>;
      final comingMsg = Message(
        fromId: msg['fromId'],
        toId: msg['toId'],
        jobPostId: msg['jobPostId'],
        message: msg['content'],
        imgUrl: msg['imageUrl'],
      );
      addNewMessage(comingMsg);
      update();
    }
  }

  addNewMessage(Message message) {
    print('add message');
    messages.insert(0, message);
    update();
  }

  removeNewMessage(Message message) {
    print('remove message');
    messages.removeAt(0);
    update();
  }
}
