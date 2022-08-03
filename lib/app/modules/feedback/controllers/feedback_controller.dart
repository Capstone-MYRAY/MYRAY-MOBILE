import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/data/models/feedback/get_feedback_request.dart';
import 'package:myray_mobile/app/data/models/feedback/get_feedback_response.dart';
import 'package:myray_mobile/app/data/models/feedback/post_feedback_request.dart';
import 'package:myray_mobile/app/data/models/feedback/put_feedback_request.dart';
import 'package:myray_mobile/app/modules/feedback/feedback_repository.dart';

class FeedBackController extends GetxController {
  final FeedBackRepository _feedBackRepository = Get.find<FeedBackRepository>();

  List<String> recommendFeedbackContent = [
    'Chủ tốt và thân thiện',
    'Chủ rất uy tín',
    'Bao ăn ở rất chu đáo',
    'Rất quan tâm đến nhu cầu của nông dân',
    'Khác'
  ];

  Future<FeedBack?> sendFeedBack(PostFeedbackRequest data) async {
    return await _feedBackRepository.sendFeedBack(data);
  }

  Future<FeedBack?> updateFeedback(PutFeedbackRequest data) async {
    return await _feedBackRepository.updateFeedback(data);
  }

  Future<GetFeedBackResponse?> getFeedback(GetFeedbackRequest data) async {
    return await _feedBackRepository.getFeedBack(data);
  }
}
