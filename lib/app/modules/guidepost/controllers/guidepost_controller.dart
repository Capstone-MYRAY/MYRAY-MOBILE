
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/guidepost/full_guidepost.dart';
import 'package:myray_mobile/app/data/models/guidepost/get_guidepost_request.dart';
import 'package:myray_mobile/app/data/models/guidepost/get_guidepost_response.dart';
import 'package:myray_mobile/app/data/models/guidepost/guidepost.dart';
import 'package:myray_mobile/app/modules/guidepost/guidepost_repository.dart';
import 'package:myray_mobile/app/modules/profile/profile_repository.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:webviewx/webviewx.dart';

class GuidepostController extends GetxController {
  final GuidepostRepository _guidepostRepository =
      Get.find<GuidepostRepository>();
  final ProfileRepository _profileRepository = Get.find<ProfileRepository>();
  Account? commentAccount;

  final int _pageSize = 5;
  int _currentPage = 0;
  bool _hasNextPage = true;
  final isLoading = false.obs;
  RxList<Guidepost> guidepostList = RxList<Guidepost>();
  RxList<FullGuidepost> fullGuidePostList = RxList<FullGuidepost>();

  late WebViewXController webviewController;

  String roleUser = AuthCredentials.instance.user!.role!;
  int currentUser = AuthCredentials.instance.user!.id!;

  //show more by tap
  int currentGuidePostIndex = -1.obs;

  @override
  void onInit() async {
    commentAccount = await _getPerson(currentUser);
    super.onInit();
  }

  Map detailGuidePost = {}.obs;

  onShowDetail(int guidePostIndex) {
    bool? beforeIndex = detailGuidePost[guidePostIndex];
    if (beforeIndex != null) {
      detailGuidePost[guidePostIndex] = !beforeIndex;
    }
  }

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
        // guidepostList.addAll(loadList.listObject ?? []);
        await _createGuidePostList(loadList.listObject ?? []);

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
    fullGuidePostList.clear();
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

  _createGuidePostList(List<Guidepost> list) async {
    if (list.isEmpty) {
      return;
    }
    for (int i = 0; i < list.length; i++) {
      Account? account = await _getPerson(list[i].createdBy);
      FullGuidepost fullGuidepost =
          FullGuidepost(guidepost: list[i], account: account);
      fullGuidePostList.add(fullGuidepost);
    }
    if (detailGuidePost.isNotEmpty) {
      detailGuidePost.clear();
    }
    for (int i = 0; i < fullGuidePostList.length; i++) {
      detailGuidePost[i] = false;
    }

    print('list length: ${fullGuidePostList.length}');
    print('detail guidepost: ${detailGuidePost.length}');
  }

  Future<Account?> _getPerson(int createdBy) async {
    return await _profileRepository.getUser(createdBy);
  }
}
