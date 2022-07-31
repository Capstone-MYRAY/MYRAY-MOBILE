import 'dart:io';

import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/message/get_message_request.dart';
import 'package:myray_mobile/app/data/models/message/message.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class MessageRepository {
  final _apiProvider = Get.find<ApiProvider>();

  Future<List<Message>> getList(GetMessageRequest data) async {
    final response =
        await _apiProvider.getMethod('/message', data: data.toJson());

    if (response.statusCode == HttpStatus.ok) {
      final messages = response.body as List;
      return messages.map((message) => Message.fromJson(message)).toList();
    }

    return [];
  }
}
