import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback_models.dart';
import 'package:myray_mobile/app/data/services/feedback_service.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class FeedBackListController extends GetxController with FeedBackService {
  late int landOwnerAccountId;
  int _currentFeedbackPage = 0;
  final int _pageSizeFeedback = 5;
  bool _hasNextpageFeedback = true;
  final isLoading = false.obs;

  RxList<FeedBack> feedBackList = RxList<FeedBack>();

  getFeedbackList() async {
    print('>>>>>id:${landOwnerAccountId}');

    GetFeedBackResponse? response;
    GetFeedbackRequest data = GetFeedbackRequest(
        page: (++_currentFeedbackPage).toString(),
        pageSize: _pageSizeFeedback.toString());

    isLoading.value = true;
    try {
      if (_hasNextpageFeedback) {
        response = await getFeedback(data);
        if (response == null ||
            response.listObject == null ||
            response.listObject!.isEmpty) {
          isLoading.value = false;
          return null;
        }

        //take feedback has belongedId
        print('>>>>list length: ${response.listObject?.length}');
        final feedBackJsonList = response.listObject!;
        feedBackList.value = feedBackJsonList.where((object) {
          return object.belongedId == landOwnerAccountId;
          //check: 4 has data
          // return object.belongedId == 4;
        }).toList();
        _hasNextpageFeedback = response.pagingMetadata!.hasNextPage;
      }
      isLoading.value = false;
      return true;
    } on CustomException catch (e) {
      printError(info: e.message);
      isLoading.value = false;
      _hasNextpageFeedback = true;
      return null;
    }
  }

  Future<void> onRefreshFeedBack() async {
    _currentFeedbackPage = 0;
    _hasNextpageFeedback = true;

    feedBackList.clear();

    await getFeedbackList();
  }
}
