import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/message/farmer_messages/farmer_message.dart';
import 'package:myray_mobile/app/data/providers/signalR_provider.dart';
import 'package:myray_mobile/app/data/services/message_service.dart';
import 'package:myray_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class FarmerMessageController extends GetxController with MessageService {
  final List<FarmerMessage> messages = [];

  Future<void> loadInitMessages() async {
    if (!SignalRProvider.instance.isConnectionOpen) {
      await SignalRProvider.instance.connectToHub();
      SignalRProvider.instance.hubConnection
          ?.on('conventionFarmer', _onMessageChange);
      await SignalRProvider.instance.hubConnection?.invoke(
          'GetListMessageForFarmer',
          args: [AuthCredentials.instance.user!.id!]);
    }
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
        final farmerMessages =
            incomingData.map((json) => FarmerMessage.fromJson(json)).toList();

        //clear current list
        messages.clear();

        //update message by incoming messages
        messages.addAll(farmerMessages);

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

  bool _markAsRead(int jobPostId) {
    try {
      final msg =
          messages.firstWhere((farmerMsg) => farmerMsg.jobPostId == jobPostId);
      if (msg.isRead) return false;

      //update isRead
      msg.isRead = true;

      return true;
    } catch (e) {
      print('Mark as read error: ${e.toString()}');
      return false;
    }
  }

  navigateToChatScreen({
    required int toId,
    required int jobPostId,
    required String toName,
    required String jobTitle,
    String? avatar,
  }) async {
    final fromId = AuthCredentials.instance.user?.id ?? 0;

    final String conventionId = Utils.generateConventionId(
        fromId, toId, jobPostId, AuthCredentials.instance.user!.role!);

    //invoke mark as read
    final isReadMark = _markAsRead(jobPostId);

    //navigate to p2p screen
    navigateToP2PMessageScreen(fromId, toId, jobPostId, toName, jobTitle,
        conventionId: conventionId, toAvatar: avatar);

    print(
        'isMarkRead $isReadMark for jobPostId $jobPostId and conventionId $conventionId');

    if (SignalRProvider.instance.isConnectionOpen && isReadMark) {
      SignalRProvider.instance.hubConnection
          ?.invoke('MarkRead', args: [fromId, conventionId]);

      //update UI
      Future.delayed(const Duration(seconds: 1))
          .then((value) => update([jobPostId]));
    }
  }
}
