
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/comment/comment_repository.dart';
import 'package:myray_mobile/app/modules/comment/controllers/comment_controller.dart';

class CommentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CommentController(), fenix: true);
    Get.lazyPut(() => CommentRepository());
  }

}