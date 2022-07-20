import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/services/bookmark_service.dart';
import 'package:myray_mobile/app/modules/bookmark/controllers/landowner_bookmark_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class LandownerBookmarkDetailsController extends GetxController
    with BookmarkService {
  final _bookmarkController = Get.find<LandownerBookmarkController>();
  final Account user = Get.arguments[Arguments.item];
  RxBool isBookmarked = RxBool(Get.arguments[Arguments.isBookmarked]);

  onToggleBookmark() {
    try {
      if (isBookmarked.value) {
        unBookmark(user.id!);
        isBookmarked.value = false;
      } else {
        bookmark(user.id!);
        isBookmarked.value = true;
      }

      _bookmarkController.refreshList(isBookmarked.value, user.id!);
    } catch (e) {
      print('Bookmark error: ${e.toString()}');
    }
  }
}
