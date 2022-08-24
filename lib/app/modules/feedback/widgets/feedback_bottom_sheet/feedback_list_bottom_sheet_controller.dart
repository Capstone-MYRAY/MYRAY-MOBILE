import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback_models.dart';
import 'package:myray_mobile/app/modules/feedback/feedback_repository.dart';

class FeedbackListBottomSheetController extends GetxController {
  final int belongedId;

  FeedbackListBottomSheetController({required this.belongedId});

  final _feedbackRepository = Get.find<FeedBackRepository>();
  RxList<FeedBack> feedbacks = RxList<FeedBack>();
  int _currentPage = 0;
  final int _pageSize = 7;
  bool _hasNextPage = true;

  final isLoading = false.obs;

  Future<void> getFeedbacks() async {
    final data = GetFeedbackRequest(
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      belongedId: belongedId,
      sortColumn: FeedbackSortColumn.createdDate,
      orderBy: SortOrder.descending,
    );

    //load feedbacks
    isLoading.value = true;
    try {
      if (_hasNextPage) {
        final response = await _feedbackRepository.getFeedBack(data);

        if (response == null || response.listObject!.isEmpty) {
          isLoading.value = false;
          return;
        }

        feedbacks.addAll(response.listObject!);

        //update hasNext
        _hasNextPage = response.pagingMetadata!.hasNextPage;
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      _hasNextPage = false;
    }
  }

  Future<void> onRefresh() async {
    //reset current page & hasNext
    _currentPage = 0;
    _hasNextPage = true;

    feedbacks.clear();

    update();
  }
}
