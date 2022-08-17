
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback_models.dart';
import 'package:myray_mobile/app/modules/feedback/feedback_repository.dart';

mixin FeedBackService{
  
  final FeedBackRepository _feedBackRepository = Get.find<FeedBackRepository>();


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