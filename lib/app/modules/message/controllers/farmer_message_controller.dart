import 'package:get/get.dart';
import 'package:myray_mobile/app/data/providers/signalR_provider.dart';
import 'package:myray_mobile/app/data/services/message_service.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';

class FarmerMessageController extends GetxController with MessageService {
  @override
  void onInit() async {
    // if (!SignalRProvider.instance.isConnectionOpen) {
    //   await SignalRProvider.instance.connectToHub();
    // }
    super.onInit();
  }

  navigateToChatScreen(int toId, int jobPostId) {
    final fromId = AuthCredentials.instance.user?.id ?? 0;
    navigateToP2PMessageScreen(fromId, toId, jobPostId);
  }
}
