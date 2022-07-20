import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/bookmark/controllers/landowner_bookmark_details_controller.dart';

class LandownerBookmarkDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandownerBookmarkDetailsController());
  }
}
