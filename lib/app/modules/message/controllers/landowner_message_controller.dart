import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/message/landowner_messages/message_job_post.dart';
import 'package:myray_mobile/app/data/providers/signalR_provider.dart';
import 'package:myray_mobile/app/data/services/message_service.dart';
import 'package:myray_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';

class LandownerMessageController extends GetxController with MessageService {
  final List<MessageJobPost> messages = [];

  Future<bool?> loadInitMessages() async {
    if (!SignalRProvider.instance.isConnectionOpen) {
      await SignalRProvider.instance.connectToHub();
      SignalRProvider.instance.hubConnection
          ?.on('convention', _onMessageChange);
      await SignalRProvider.instance.hubConnection?.invoke(
          'GetListMessageForLandowner',
          args: [AuthCredentials.instance.user!.id!]);
      return true;
    }

    return null;
  }

  _onMessageChange(List<Object>? arguments) {
    if (arguments != null) {
      try {
        final dashboardController = Get.find<DashboardController>();
        if (Get.currentRoute == Routes.init &&
            dashboardController.tabIndex == 3) {
          EasyLoading.show();
        }
        final incomingData = arguments[1] as List;
        print(incomingData.toString());
        final messageJobPosts =
            incomingData.map((json) => MessageJobPost.fromJson(json)).toList();

        //clear current list
        messages.clear();

        //update message by incoming messages
        messages.addAll(messageJobPosts);

        //update UI
        if (Get.currentRoute == Routes.init &&
            dashboardController.tabIndex == 3) {
          Future.delayed(const Duration(milliseconds: 400)).then((value) {
            update();
            if (EasyLoading.isShow) {
              EasyLoading.dismiss();
            }
          });
        } else {
          update();
        }
      } catch (e) {
        if (EasyLoading.isShow) {
          EasyLoading.dismiss();
        }
        print(e.toString());
      }
    }
  }

  bool _markAsRead(int jobPostId, String conventionId) {
    try {
      final jobPost = messages.firstWhere((jobPost) => jobPost.id == jobPostId);
      final msg = jobPost.farmers.firstWhere(
          (farmerMsg) => farmerMsg.lastMessage.conventionId == conventionId);
      if (msg.lastMessage.isRead) return false;

      //update isRead
      msg.lastMessage.isRead = true;

      return true;
    } catch (e) {
      print('Mark as read error: ${e.toString()}');
      return false;
    }
  }

  navigateToChatScreen(
      {required int toId,
      required int jobPostId,
      required String conventionId,
      required String toName,
      required String jobTitle,
      String? avatar}) async {
    final fromId = AuthCredentials.instance.user?.id ?? 0;

    //invoke mark as read
    final isReadMark = _markAsRead(jobPostId, conventionId);

    //navigate to p2p chat screen
    navigateToP2PMessageScreen(fromId, toId, jobPostId, toName, jobTitle,
        conventionId: conventionId, toAvatar: avatar);

    if (SignalRProvider.instance.isConnectionOpen && isReadMark) {
      await SignalRProvider.instance.hubConnection
          ?.invoke('MarkRead', args: [fromId, conventionId]);

      //update UI
      Future.delayed(const Duration(seconds: 1))
          .then((value) => update([conventionId]));
    }
  }
}
