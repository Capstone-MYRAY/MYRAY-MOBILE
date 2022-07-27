import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/comment/comment.dart';
import 'package:myray_mobile/app/data/models/comment/get_comment_request.dart';
import 'package:myray_mobile/app/data/models/comment/get_comment_response.dart';
import 'package:myray_mobile/app/data/models/comment/post_comment_request.dart';
import 'package:myray_mobile/app/modules/comment/comment_repository.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class CommentController extends GetxController {
  final CommentRepository _commentRepository = Get.find<CommentRepository>();

  final _pageSize = 5;
  int _currentPage = 0;
  bool _hasNextPage = true;
  final isLoading = false.obs;
  
  RxList<Comment> commentList = RxList<Comment>();

  late GlobalKey<FormState> formKey;
  late TextEditingController commentController;

  @override
  void onInit() async {
    formKey = GlobalKey<FormState>();
    commentController = TextEditingController();
    super.onInit();
  }

  Future<bool?> getComments(int guidepostId) async {
    GetCommentResponse? loadList = GetCommentResponse();
    GetCommentRequest data = GetCommentRequest(
      page: (++_currentPage).toString(),
      pageSize: _pageSize.toString(),
      guidepostId: guidepostId.toString(),
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

  onCloseComment(){
    Get.back();
    _currentPage = 0;
    _hasNextPage = true;
    commentController.clear();
    commentList.clear();
  }
  
}
