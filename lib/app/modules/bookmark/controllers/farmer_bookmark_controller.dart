import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/bookmark/bookmark.dart';
import 'package:myray_mobile/app/data/models/bookmark/get_bookmark_request.dart';
import 'package:myray_mobile/app/data/models/bookmark/get_bookmark_response.dart';
import 'package:myray_mobile/app/modules/bookmark/bookmark_repository.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

import '../../../shared/constants/app_colors.dart';

class FarmerBookmarkController extends GetxController {
  final BookmarkRepository _bookmarkRepository = Get.find<BookmarkRepository>();
  int test = 3;
  RxList<GetBookmarkResponse?> bookmarkResponse = RxList<GetBookmarkResponse>();
  RxList<Bookmark> listBookmark = RxList<Bookmark>();
  final int _pageSize = 5;
  //paging bookmark list
  int _currentPage = 0;
  bool _hasNextPage = true;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  getAllBookmarkAccount() async {
    GetBookmarkResponse? list;
    GetBookmarkRequest data = GetBookmarkRequest(
      page: (++_currentPage).toString(),
      pageSize: _pageSize.toString(),
      accountId: AuthCredentials.instance.user!.id!.toString(),
    );
    print('id: ${AuthCredentials.instance.user!.id!}');
    isLoading(true);
    try {
      if (_hasNextPage) {
        list = await _bookmarkRepository.getAllBookmarkAccount(data);
        if (list == null) {
          isLoading(false);
          return null;
        }

        listBookmark.addAll(list.listObject);
        print('bookmark: ${listBookmark.length}');
        _hasNextPage = list.pagingMetadata.hasNextPage;
      }
      isLoading(false);
      return true;
    } on CustomException catch (e) {
      print('error in farmer boormark controller: $e');
      isLoading(false);
      _hasNextPage = false;
    }
    return null;
  }

  Future<void> onRefresh() async {
    _currentPage = 0;
    _hasNextPage = true;

    listBookmark.clear();
    await getAllBookmarkAccount();
  }

  unBookmarkAccount(int bookmarkId) async {
    try {
      final result = await _bookmarkRepository.unBookmarkAccount(bookmarkId);
      if (result!) {
        listBookmark
            .removeWhere((bookmark) => bookmark.bookmarkId == bookmarkId);
        EasyLoading.show();
        onRefresh();
        Future.delayed(const Duration(milliseconds: 500), () {
          EasyLoading.dismiss();
          CustomSnackbar.show(
              title: 'Thành công',
              message: 'Đã xóa tài khoản khỏi danh sách yêu thích');
        });
        return;
      }
      CustomSnackbar.show(
          title: "Thất bại",
          message: "Gửi báo cáo không thành công",
          backgroundColor: AppColors.errorColor);
    } on CustomException catch (e) {
      CustomSnackbar.show(
          title: "Thất bại",
          message: "Gửi báo cáo không thành công",
          backgroundColor: AppColors.errorColor);
      print('lỗi: $e');
    }
  }
}
