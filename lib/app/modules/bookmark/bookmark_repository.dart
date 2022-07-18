
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/bookmark/get_bookmark_request.dart';
import 'package:myray_mobile/app/data/models/bookmark/get_bookmark_response.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class BookmarkRepository{

  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<bool?> bookmarkAccount (int accountId) async {
    final response = await _apiProvider.postMethod('/bookmark?bookmarkId=$accountId', {});
    //bookmarked
    if(response.isOk){
      return true;
    }
    //check bookmark or not
    if(response.statusCode == HttpStatus.internalServerError){
      return false;
    }
    return null;
  }

  Future<bool?> unBookmarkAccount(int bookmarkId) async {
    final response = await _apiProvider.deleteMethod('/bookmark/$bookmarkId');
    if(response.isOk){
      return true;
    }
    if(response.statusCode == HttpStatus.badRequest){
      return false;
    }
    return null;
  }

  Future<GetBookmarkResponse?> getAllBookmarkAccount(GetBookmarkRequest data) async {
  
    final response = await _apiProvider.getMethod('/bookmark', data: data.toJson());
      print('in bookmark repo: ${response.headers}');
    if(response.isOk){
      return GetBookmarkResponse.fromJson(response.body);
    }
    return null;
  }

  Future<bool?> checkBookmark(int accountId) async {
    final response = await _apiProvider.getMethod('/bookmark/$accountId');
    if(response.statusCode == HttpStatus.noContent){
      return false;
    }
    if(response.statusCode == HttpStatus.ok){
      return true;
    }
    return null;
  }

}