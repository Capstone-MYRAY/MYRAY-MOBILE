import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/bookmark/bookmark_response.dart';
import 'package:myray_mobile/app/data/models/bookmark/get_bookmark_request.dart';
import 'package:myray_mobile/app/data/models/bookmark/get_bookmark_response.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/services/message_service.dart';
import 'package:myray_mobile/app/modules/bookmark/bookmark_repository.dart';
import 'package:myray_mobile/app/modules/bookmark/controllers/farmer_bookmark_controller.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/modules/profile/profile_repository.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_msg.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/data/models/job_post/farmer_job_post_detail_response.dart';

class FarmerJobPostDetailController extends GetxController with MessageService {
  final _jobPostRepository = Get.find<JobPostRepository>();
  final _accountRepository = Get.find<ProfileRepository>();
  final _bookmarkRepository = Get.find<BookmarkRepository>();
  final JobPost jobPost;
  final isApplied = false.obs;
  final isAppliedHourJob = false.obs;
  Rx<FarmerJobPostDetailResponse>? detailPost;
  Rx<Account>? landownerAccount;
  Rx<bool> isBookmark = false.obs;

  FarmerJobPostDetailController({required this.jobPost});

  @override
  void onInit() async {
    super.onInit();
    _getLanownerAccount(jobPost.publishedBy);
    _checkFarmerAppliedOrNot(jobPost.id);
    checkAppliedHourJob();
    checkBookmark(jobPost.publishedBy);
  }

  void navigateToChatScreen() {
    print('Im here');
    final fromId = AuthCredentials.instance.user?.id ?? 0;
    final toId = landownerAccount?.value.id ?? 0;
    final jobPostId = jobPost.id;

    navigateToP2PMessageScreen(
      fromId,
      toId,
      jobPostId,
      toAvatar: landownerAccount?.value.imageUrl,
    );
  }

  Future<FarmerJobPostDetailResponse?> getJobPostDetail() async {
    //call api
    final FarmerJobPostDetailResponse? post =
        await _jobPostRepository.getFarmerJobPostdDetail(jobPost.id);
    print("object: ${post!.type}");
    return post;
  }

  _getLanownerAccount(int landownerId) async {
    await _accountRepository.getUser(landownerId).then(
          (value) => {
            if (value != null)
              {
                landownerAccount = value.obs,
              },
          },
        );
  }

  //Check farmer apply to hour job or not
  checkAppliedHourJob() async {
    final isApplied = await _jobPostRepository.checkAppliedHourJob();
    isAppliedHourJob(isApplied);
    isAppliedHourJob.value
        ? print("Đã ứng tuyển một job công khác ? ")
        : print('Chưa ứng tuyển');
  }

  getExpiredDate(DateTime publishedDate, int numberPublishDate) {
    var publishDate = publishedDate.toLocal();
    var expiredDate = DateTime(publishDate.year, publishDate.month,
        publishDate.day + numberPublishDate - 1);
    return expiredDate;
  }

  checkExpiredDate(DateTime expiredDate) {
    var now = DateTime.now().toLocal();
    if (now.compareTo(expiredDate) > 0) {
      return true;
    }
    return false;
  }

  applyJob(int idJobPost) async {
    Get.back();
    await _jobPostRepository.applyJob(idJobPost).then(
          (result) => {
            if (result)
              {
                const LoadingBuilder(),
                CustomSnackbar.show(
                    title: "Thành công", message: AppMsg.MSG3006),
              }
            else
              {
                CustomSnackbar.show(
                    title: "Thất bại",
                    message: AppMsg.MSG3007,
                    backgroundColor: AppColors.errorColor),
              }
          },
        );
    _checkFarmerAppliedOrNot(idJobPost);
    print("Đã apply bài post có id $idJobPost");
  }

  //applied: false, not applied: true (200)
  _checkFarmerAppliedOrNot(int jobPostId) async {
    final result = await _jobPostRepository.checkFarmerAppliedOrNot(jobPostId);
    isApplied(result);
    print(isApplied.value ? 'applied' : 'not applied');
  }

  bookmarkAccount(int accountId) async {
    if (accountId == -1) {
      return;
    }
    bool? result = await _bookmarkRepository.bookmarkAccount(accountId);
    if (result != null && result) {
      isBookmark.value = true;
      //show Toast message
    } else {
      isBookmark.value = false;
      await _bookmarkRepository.unBookmarkAccount(accountId);
    }
    //chưa có check bookmark or not
  }

  //temp check is like
    final int _pageSize = 5;
    bool _hasNextPage = true;
  _getAllBookmark(int? currentPage) async {
    //1. Load danh dách các tài khoản đã like
    //2. So sánh id từng tài khoản với ID chủ đất bài post
    //3. Đúng -> isBookmark = true, Sai -> isBookmark = false
    //gọi hàm này khi onInit
    currentPage ??= 0;
    
    GetBookmarkResponse? list; 
    List<BookmarkResponse> listBookmark = RxList<BookmarkResponse>();
    GetBookmarkRequest data = GetBookmarkRequest(
      page: (++currentPage).toString(),
      pageSize: _pageSize.toString(),
      accountId: AuthCredentials.instance.user!.id!.toString());

    try{
      if(_hasNextPage){
        print('in load bookmark');
        list = await _bookmarkRepository.getAllBookmarkAccount(data);
        if(list == null){
          return;
        }
        listBookmark.addAll(list.listObject);
        _hasNextPage = list.pagingMetadata.hasNextPage;
        if(_hasNextPage){
          _getAllBookmark(currentPage);
        }
      }
    }on CustomException catch(e){
      print('Error in load bookmark to check: $e');
    }
    return listBookmark;
  }
  checkBookmark(int accountId) async{
    List<BookmarkResponse> listBookmark = RxList<BookmarkResponse>();
    listBookmark = await _getAllBookmark(0);
    if(listBookmark.isEmpty){
      isBookmark.value = false;
    }
    // print('lenght: ${listBookmark.length}');
    isBookmark.value = listBookmark.where((element) => element.bookmarkId == accountId).isNotEmpty;
  }
}
