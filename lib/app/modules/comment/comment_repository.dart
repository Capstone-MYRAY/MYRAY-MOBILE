
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/comment/comment.dart';
import 'package:myray_mobile/app/data/models/comment/get_comment_request.dart';
import 'package:myray_mobile/app/data/models/comment/get_comment_response.dart';
import 'package:myray_mobile/app/data/models/comment/post_comment_request.dart';
import 'package:myray_mobile/app/data/models/comment/put_comment_request.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class CommentRepository{

  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final _url = '/comment';

  Future<GetCommentResponse?> getComment(GetCommentRequest data) async{
    final response = await _apiProvider.getMethod(_url, data: data.toJson());  
    if(response.statusCode == HttpStatus.ok){
      return GetCommentResponse.fromJson(response.body);
    }
    return null;
  }

  Future<Comment?> createComment(PostCommentRequest data) async {
    final response = await _apiProvider.postMethod(_url, data.toJson());
    if(response.statusCode == HttpStatus.ok){
      return Comment.fromJson(response.body);
    }
    return null;
  }

  Future<Comment?> deleteComment(int commentId) async {
    final response = await _apiProvider.deleteMethod('$_url/$commentId');
    if(response.statusCode == HttpStatus.ok){
      return Comment.fromJson(response.body);
    }
    return null;
  }

  Future<Comment?> updateComment(PutCommentRequest data) async {
    final response = await _apiProvider.putMethod(_url, data.toJson());
    if(response.statusCode == HttpStatus.ok){
      return Comment.fromJson(response.body);
    }
    return null;
  }

}