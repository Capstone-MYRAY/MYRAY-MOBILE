
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/data/models/feedback/post_feedback_request.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class FeedBackRepository{

  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  //send a feedback
  Future<FeedBack?> sendFeedBack(PostFeedbackRequest data) async {
    final response = await _apiProvider.postMethod('/feedback', data.toJson());
    if(response.isOk){
      return FeedBack.fromJson(response.body);
    }
    return null;
  }
}