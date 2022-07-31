import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/comment/comment.dart';
import 'package:myray_mobile/app/data/models/comment/get_comment_request.dart';
import 'package:myray_mobile/app/data/models/comment/get_comment_response.dart';
import 'package:myray_mobile/app/data/models/comment/post_comment_request.dart';
import 'package:myray_mobile/app/data/models/comment/put_comment_request.dart';
import 'package:myray_mobile/app/modules/comment/comment_repository.dart';
import 'package:myray_mobile/app/modules/comment/widgets/comment_modal_bottom_sheet.dart';
import 'package:myray_mobile/app/modules/comment/widgets/comment_update_bottom_sheet.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class CommentController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final CommentRepository _commentRepository = Get.find<CommentRepository>();

  int currentUser = AuthCredentials.instance.user!.id!;

  final _pageSize = 10;
  int _currentPage = 0;
  bool _hasNextPage = true;
  final isLoading = false.obs;

  RxList<Comment> commentList = RxList<Comment>();

  late GlobalKey<FormState> formKey;
  late GlobalKey<FormState> editCommentFormKey;
  late TextEditingController commentController;
  late TextEditingController editCommentController;

  @override
  void onInit() async {
    formKey = GlobalKey<FormState>();
    editCommentFormKey = GlobalKey<FormState>();
    commentController = TextEditingController();
    editCommentController = TextEditingController();

    super.onInit();
  }

  Future<bool?> getComments(int guidepostId) async {
    GetCommentResponse? loadList = GetCommentResponse();
    GetCommentRequest data = GetCommentRequest(
      page: (++_currentPage).toString(),
      pageSize: _pageSize.toString(),
      guidepostId: guidepostId.toString(),
      sortColumn: CommentSortColumn.createdDate,
      orderBy: SortOrder.descending,
    );
    isLoading(true);
    try {
      if (_hasNextPage) {
        loadList = await _commentRepository.getComment(data);
        if (loadList == null) {
          isLoading(false);
          return null;
        }
        commentList.addAll(loadList.listObject ?? []);
        _hasNextPage = loadList.pagingMetadata!.hasNextPage;
      }
      isLoading(false);
      print('length: ${commentList.length}');

      return true;
    } on CustomException catch (e) {
      _currentPage = 0;
      isLoading(false);
      _hasNextPage = true;
      print('error here: ${e.message}');
    }
    return null;
  }

  Future<void> onRefresh(int guidepostId) async {
    _currentPage = 0;
    _hasNextPage = true;

    commentList.clear();
    await getComments(guidepostId);
  }

  Future<Comment?> createComment(PostCommentRequest data) async {
    return await _commentRepository.createComment(data);
  }

  bool validateInputComment(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    if (Utils.limitString.hasMatch(value)) {
      return true;
    }
    return false;
  }

  String? validateComment(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng nhập nội dung bình luận';
    }
    if (!Utils.limitString.hasMatch(value!)) {
      return 'Bạn đã nhập quá 1000 từ';
    }
    return null;
  }

  onDeleteComment(int commentId) async {
    Get.back(); //tắt confirm dialog
    EasyLoading.show();
    try {
      Comment? comment = await _commentRepository.deleteComment(commentId);
      Future.delayed(const Duration(milliseconds: 1200), () {
        EasyLoading.dismiss();
        if (comment != null) {
          EasyLoading.showSuccess('Đã xóa');
          // update(commentList);
          commentList.removeWhere((comment) => comment.id == commentId);
          return;
        }
        EasyLoading.showError('Không thể xóa');
      });
    } on CustomException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Đã có lỗi xảy ta');
      print(e.message);
    }
  }

  Future<dynamic> onEditComment(BuildContext context, Comment comment) {

    return CommentUpdateBottomSheet.showUpdateForm(
      buildContext: context,
      formKey: editCommentFormKey,
      editCommentController: editCommentController,
      comment: comment,
      validateComment: validateComment,
      update: () {
        print('comment id: ${comment.id}');

        onUpdateComment(comment);
      },
    );
  }
  onUpdateComment(Comment oldComment) async  {
    // bool isFormValid = formKey.currentState.validate();
    print('${editCommentFormKey.currentContext}');

    if (editCommentFormKey.currentState != null &&
        editCommentFormKey.currentState!.validate()) {
      print('submit');
      PutCommentRequest data = PutCommentRequest(
        id: oldComment.id,
        content: editCommentController.text.trim(),
      );
      EasyLoading.show();

      try {
        Comment? comment = await _commentRepository.updateComment(data);        
        // commentList.clear();
        print('list count: ${commentList.length}');
        Future.delayed(const Duration(milliseconds: 1200), () {
          EasyLoading.dismiss();
          //show comment box
          if (comment == null) {
            EasyLoading.showError('Không thể xóa');
            return;
          }
          onRefresh(oldComment.guidepostId);
          EasyLoading.showSuccess('Đã cập nhật');
        });
      } on CustomException catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showError('Đã có lỗi xảy ta');
        print(e.message);
      }
    }
  }

  onCloseComment() {
    Get.back();
    _currentPage = 0;
    _hasNextPage = true;
    commentController.clear();
    commentList.clear();
  }
}
