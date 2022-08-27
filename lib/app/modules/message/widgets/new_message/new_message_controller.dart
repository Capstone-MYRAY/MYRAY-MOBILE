import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myray_mobile/app/data/enums/activities.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/message/message.dart';
import 'package:myray_mobile/app/data/models/message/new_message_request.dart';
import 'package:myray_mobile/app/data/providers/signalR_provider.dart';
import 'package:myray_mobile/app/data/services/services.dart';
import 'package:myray_mobile/app/modules/message/controllers/p2p_message_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:signalr_netcore/hub_connection.dart';

class NewMessageController extends GetxController with UploadImageService {
  final fromId = Get.arguments[Arguments.from];
  final toId = Get.arguments[Arguments.to];
  final jobPostId = Get.arguments[Arguments.jobPostId];
  final _picker = ImagePicker();
  late P2PMessageController _p2pMessageController;

  late TextEditingController messageController;
  var isDisplaySendButton = false.obs;

  @override
  void onInit() {
    messageController = TextEditingController();
    _p2pMessageController = Get.find<P2PMessageController>();
    super.onInit();
  }

  Future<String?> _uploadImage(XFile selectedImage) async {
    File imageFile = File(selectedImage.path);
    var fileName = selectedImage.path.split('/').last;
    var multipleFile = MultipartFile(imageFile, filename: fileName);

    final uploadResponse = await uploadImage([multipleFile]);
    if (uploadResponse == null) return null;
    return uploadResponse.files[0].link;
  }

  sendImage(Activities action) async {
    final XFile? selectedImage = await _picker.pickImage(
      source: action == Activities.gallery
          ? ImageSource.gallery
          : ImageSource.camera,
      imageQuality: 60,
    );

    if (selectedImage == null) return;

    if (SignalRProvider.instance.hubConnection?.state ==
        HubConnectionState.Connected) {
      //display image in ui
      final message = Message(
        fromId: fromId,
        toId: toId,
        jobPostId: jobPostId,
        imgUrl: selectedImage.path,
        createdDate: DateTime.now(),
      );

      try {
        _p2pMessageController.addNewMessage(message);

        //upload image to server
        String? url = await _uploadImage(selectedImage);
        if (url == null) throw CustomException('Upload image error');

        //send image
        final newMessage = NewMessageRequest(
          fromId: fromId,
          toId: toId,
          jobPostId: jobPostId,
          imgUrl: url,
        );

        await SignalRProvider.instance.hubConnection
            ?.invoke('SendMessage', args: [newMessage]);
        _p2pMessageController.isChanged = true;
      } catch (e) {
        _p2pMessageController.removeNewMessage(message);
        CustomSnackbar.show(
          title: AppStrings.titleError,
          message: 'Có lỗi xảy ra',
          backgroundColor: AppColors.errorColor,
        );
        print('Send msg error: ${e.toString()}');
      }
    }
  }

  sendMessage() async {
    final msg = messageController.text.trim();

    if (msg.isEmpty) return;

    final newMessage = NewMessageRequest(
      fromId: fromId,
      toId: toId,
      jobPostId: jobPostId,
      message: msg,
    );

    if (SignalRProvider.instance.hubConnection?.state ==
        HubConnectionState.Connected) {
      //create message
      final message = Message(
        fromId: fromId,
        toId: toId,
        jobPostId: jobPostId,
        message: msg,
      );

      try {
        //display message on screen
        _p2pMessageController.addNewMessage(message);
        messageController.clear();
        isDisplaySendButton.value = false;
        _p2pMessageController.isChanged = true;
        await SignalRProvider.instance.hubConnection
            ?.invoke('SendMessage', args: [newMessage]);
      } catch (e) {
        _p2pMessageController.removeNewMessage(message);
        CustomSnackbar.show(
          title: AppStrings.titleError,
          message: 'Có lỗi xảy ra',
          backgroundColor: AppColors.errorColor,
        );
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
