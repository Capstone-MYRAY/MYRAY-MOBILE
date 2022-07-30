import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/guidepost/get_guidepost_request.dart';
import 'package:myray_mobile/app/data/models/guidepost/get_guidepost_response.dart';
import 'package:myray_mobile/app/data/models/guidepost/guidepost.dart';
import 'package:myray_mobile/app/modules/guidepost/guidepost_repository.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class GuidepostController extends GetxController {
  final GuidepostRepository _guidepostRepository =
      Get.find<GuidepostRepository>();
  
  final int _pageSize = 5;
  int _currentPage = 0;
  bool _hasNextPage = true;
  final isLoading = false.obs;
  RxList<Guidepost> guidepostList = RxList<Guidepost>();
  

  Future<bool?> getGuidepost() async {
    GetGuidepostRequest data = GetGuidepostRequest(
      page: (++_currentPage).toString(),
      pageSize: _pageSize.toString(),
    );
    GetGuidepostResponse? loadList = GetGuidepostResponse();
    isLoading(true);
    try {
      if (_hasNextPage) {
        loadList = await _guidepostRepository.getGuideposts(data);
        if (loadList == null) {
          isLoading(false);
          return null;
        }
        guidepostList.addAll(loadList.listObject ?? []);
        _hasNextPage = loadList.pagingMetadata!.hasNextPage;
      }
      isLoading(false);
      return true;
    } on CustomException catch (e) {
      print(e.message);
      isLoading.value = false;
      _hasNextPage = false;
    }
    return null;
  }

  Future<void> onRefresh() async {
    _currentPage = 0;
    _hasNextPage = true;

    guidepostList.clear();
    await getGuidepost();
  }

  String changeTagType(String content) {
    String tempt = '';
    if (content.contains('oembed')) {
      tempt = content.replaceAll('oembed', 'iframe');
      tempt = tempt.replaceAll('url', 'src');
    print('temp: $tempt');
      return tempt;
    }
    return content;
  }
}
