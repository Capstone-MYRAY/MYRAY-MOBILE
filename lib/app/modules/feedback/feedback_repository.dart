
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/data/models/feedback/get_feedback_request.dart';
import 'package:myray_mobile/app/data/models/feedback/get_feedback_response.dart';
import 'package:myray_mobile/app/data/models/feedback/post_feedback_request.dart';
import 'package:myray_mobile/app/data/models/feedback/put_feedback_request.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class FeedBackRepository{

  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final _url = '/feedback';

  //send a feedback
  Future<FeedBack?> sendFeedBack(PostFeedbackRequest data) async {
    final response = await _apiProvider.postMethod(_url, data.toJson());
    if(response.isOk){
      return FeedBack.fromJson(response.body);
    }
    return null;
  }

  //get feedback list
  Future<GetFeedBackResponse?> getFeedBack(GetFeedbackRequest data) async {
    final response = await _apiProvider.getMethod(_url, data: data.toJson());
    if(response.statusCode == HttpStatus.ok){
      return GetFeedBackResponse.fromJson(response.body);
    }
    return null;
  }

  Future<FeedBack?> updateFeedback(PutFeedbackRequest data) async {
    final response = await _apiProvider.putMethod(_url, data.toJson());
    if(response.statusCode == HttpStatus.ok){
      return FeedBack.fromJson(response.body);
    }
    return null;
  }


}