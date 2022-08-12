import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/job_post/get_request_job_post_list.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post_response.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/utils/user_current_location.dart';

class FarmerHomeController extends GetxController {
  final _repository = Get.find<JobPostRepository>();
  late int page = 1;
  var isExpired = false.obs;
  //list of not pin post
  RxList<JobPost> listObject = RxList<JobPost>();
  //List of pin post
  RxList<JobPost> secondObject = RxList<JobPost>();
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextpage = true;

  final isLoading = false.obs;

  late TextEditingController searchController;
  double? lat = CurrentLocation.instance.userCurrentLocation!.latitude;
  double? long = CurrentLocation.instance.userCurrentLocation!.longtitude;

  @override
  void onInit() async {
    searchController = TextEditingController();
    super.onInit();
  }

  getExpiredDate(DateTime publishedDate, int numberPublishDate) {
    var publishDate = publishedDate.toLocal();
    var expiredDate = DateTime(publishDate.year, publishDate.month,
        publishDate.day + numberPublishDate);
    return expiredDate;
  }

  checkExpiredDate(DateTime expiredDate) {
    var now = DateTime.now().toLocal();
    if (now.compareTo(expiredDate) > 0) {
      return true;
    }
    return false;
  }

  getListJobPost() async {
    GetRequestJobPostList data = GetRequestJobPostList(
        status: "2",
        page: (++_currentPage).toString(),
        pageSize: (_pageSize).toString(),
        sortColumn: JobPostSortColumn.createdDate,
        // page: "1",
        orderBy: SortOrder.descending);

    isLoading.value = true;
    try {
      if (_hasNextpage) {
        JobPostResponse? response = await _repository.getJobPostList(data);
        if (response == null ||
            response.listJobPost.isEmpty && response.secondObject!.isEmpty) {
          print('here');
          isLoading(false);
          return null;
        }
        listObject.addAll(response.listJobPost);
        secondObject.addAll(response.secondObject!);
        _hasNextpage = response.pagingMetadata.hasNextPage;
        print('second object: ${listObject.length}');
      }
      isLoading.value = false;
      return true;
    } on CustomException catch (e) {
      isLoading.value = false;
      _hasNextpage = false;
      print('error: $e');
      return null;
    }
  }

  Future<void> onRefresh() async {
    //reset current page & hasNext
    _currentPage = 0;
    _hasNextpage = true;

    //clear garden list
    listObject.clear();
    secondObject.clear();

    await getListJobPost();
  }
  //list Object: các bài đăng thường
  //second list object: các bài đăng đặc biệt

  navigateToDetailPage(Rx<JobPost> jobPost) {
    Get.toNamed(Routes.farmerJobPostDetail,
        arguments: {Arguments.item: jobPost});
  }

  //get distance
  getDistance(double gardenLat, double gardenLong) {
    double distance = 0.0;
    if (lat != null && long != null) {
      distance = Geolocator.distanceBetween(gardenLat, gardenLong, lat!, long!);

      distance = double.parse((distance / 1000).toStringAsFixed(0));
    }
    return distance;
  }
}
