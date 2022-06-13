import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/message/controllers/landowner_message_controller.dart';

class LandownerMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandownerMessageController());
  }
}
