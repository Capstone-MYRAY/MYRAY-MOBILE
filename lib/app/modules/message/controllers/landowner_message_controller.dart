import 'package:get/get.dart';
import 'package:myray_mobile/app/data/providers/signalR_provider.dart';
import 'package:myray_mobile/app/data/services/message_service.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';

class LandownerMessageController extends GetxController with MessageService {
  @override
  void onInit() async {
    await SignalRProvider.instance.connectToHub();
    super.onInit();
  }

  navigateToChatScreen(int toId, int jobPostId) {
    final fromId = AuthCredentials.instance.user?.id ?? 0;
    const testAvatar =
        'https://cdna.artstation.com/p/assets/images/images/031/825/628/large/glawdys-hodiesne-sans-titre-1.jpg?1604688006';
    navigateToP2PMessageScreen(fromId, toId, jobPostId, toAvatar: testAvatar);
  }
}
