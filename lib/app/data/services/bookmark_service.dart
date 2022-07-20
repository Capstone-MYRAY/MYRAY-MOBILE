import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/bookmark/bookmark_repository.dart';

mixin BookmarkService {
  final _bookmarkRepository = Get.find<BookmarkRepository>();

  Future<bool> isBookMark(int bookmarkId) async {
    final response = await _bookmarkRepository.checkBookmark(bookmarkId);
    if (response == null || response == false) return false;
    return true;
  }

  Future<bool> bookmark(int bookmarkId) async {
    final response = await _bookmarkRepository.bookmarkAccount(bookmarkId);
    if (response == null || response == false) return false;
    return true;
  }

  Future<bool> unBookmark(int bookmarkId) async {
    final response = await _bookmarkRepository.unBookmarkAccount(bookmarkId);
    if (response == null || response == false) return false;
    return true;
  }
}
