import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/message/controllers/p2p_message_controller.dart';

class P2PMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => P2PMessageController());
  }
}
