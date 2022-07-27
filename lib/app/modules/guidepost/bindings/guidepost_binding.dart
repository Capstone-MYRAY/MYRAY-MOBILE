
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/comment/comment_repository.dart';
import 'package:myray_mobile/app/modules/guidepost/controllers/guidepost_controller.dart';
import 'package:myray_mobile/app/modules/guidepost/guidepost_repository.dart';

class GuidepostBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => GuidepostController(), fenix: true);
    Get.lazyPut(() => GuidepostRepository());
  }

}