import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/bookmark/bookmark.dart';
import 'package:myray_mobile/app/data/models/bookmark/get_bookmark_request.dart';
import 'package:myray_mobile/app/data/services/bookmark_service.dart';
import 'package:myray_mobile/app/modules/bookmark/bookmark_repository.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class LandownerBookmarkController extends GetxController with BookmarkService {
  final _bookmarkRepository = Get.find<BookmarkRepository>();
  RxList<Bookmark> bookmarks = RxList<Bookmark>();
  int _currentPage = 0;
  final int _pageSize = 8;
  bool _hasNextPage = true;

  final isLoading = false.obs;

  final isBuildFuture = false.obs;

  Future<bool?> getBookmarks() async {
    final int accountId = AuthCredentials.instance.user!.id!;

    GetBookmarkRequest data = GetBookmarkRequest(
      accountId: accountId.toString(),
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      sortColumn: BookmarkSortColumn.createdDate,
      orderBy: SortOrder.descending,
    );

    //load bookmarks
    isLoading.value = true;
    try {
      if (_hasNextPage) {
        final response = await _bookmarkRepository.getAllBookmarkAccount(data);
        if (response == null || response.listObject.isEmpty) {
          isLoading.value = false;
          return null;
        }

        bookmarks.addAll(response.listObject);
        //update hasNext
        _hasNextPage = response.pagingMetadata.hasNextPage;
      }
      isLoading.value = false;
      return true;
    } on CustomException {
      isLoading.value = false;
      _hasNextPage = false;
      return null;
    }
  }

  Future<void> onRefresh() async {
    //reset current page & hasNext
    _currentPage = 0;
    _hasNextPage = true;

    //clear garden list
    bookmarks.clear();

    update();
  }

  onToggleBookmark(bool isBookmarked, int bookmarkId) {
    try {
      if (isBookmarked) {
        unBookmark(bookmarkId);
        isBookmarked = false;
      } else {
        bookmark(bookmarkId);
        isBookmarked = true;
      }

      //update bookmark in list
      bookmarks
          .firstWhere((bookmark) => bookmark.bookmarkId == bookmarkId)
          .isBookmarked = isBookmarked;

      bookmarks.refresh();
    } catch (e) {
      print('Bookmark error: ${e.toString()}');
    }
  }
}
