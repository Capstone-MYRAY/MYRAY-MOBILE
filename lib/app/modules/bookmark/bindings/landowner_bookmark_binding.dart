import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/bookmark/controllers/landowner_bookmark_controller.dart';

class LandownerBookmarkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandownerBookmarkController());
  }
}
