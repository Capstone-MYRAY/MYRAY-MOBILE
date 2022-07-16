import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/message/widgets/new_message/new_message_controller.dart';

class NewMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewMessageController());
  }
}
