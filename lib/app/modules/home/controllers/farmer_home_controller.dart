import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/area/area_models.dart';
import 'package:myray_mobile/app/data/models/filter_object.dart';
import 'package:myray_mobile/app/data/models/job_post/get_request_job_post_list.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post_response.dart';
import 'package:myray_mobile/app/data/models/tree_type/get_tree_type_request.dart';
import 'package:myray_mobile/app/data/models/tree_type/get_tree_type_response.dart';
import 'package:myray_mobile/app/data/models/tree_type/tree_type.dart';
import 'package:myray_mobile/app/data/models/work_type/work_type_models.dart';
import 'package:myray_mobile/app/data/services/services.dart';
import 'package:myray_mobile/app/data/services/work_type_repository.dart';
import 'package:myray_mobile/app/modules/home/widgets/farmer_filter.dart/tree_type_field.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/utils/user_current_location.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/controls/my_date_picker.dart';

class FarmerHomeController extends GetxController
    with WorkTypeRepository, TreeTypeService {
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

  //loại hình trả lương
  String? paidTypeFilter;

  //Loại công việc
  GetWorkTypeResponse? workTypeResponse;
  final List<FilterObject> workTypeList = [
    FilterObject(name: 'Tất cả', value: null)
  ];
  Rx<String> selectedWorkTypes = ''.obs;
  List<String> labelWorkType = [];
  int? workTypeId;

  //Loại cây
  RxList<TreeType> treeTypes = RxList<TreeType>();
  RxList<TreeType> selectedTreeTypes = RxList<TreeType>();

  //Lương
  Rx<FilterObject> selectSalaryRange =
      FilterObject(name: 'Mức lương', value: null).obs;
  List<FilterObject> filterSalaryList = [
    FilterObject(
      name: 'Mức lương',
      value: null,
    ),
    FilterObject(
      name: '>= 100.000 đ',
      value: 100000,
    ),
    FilterObject(
      name: '>= 500.000 đ',
      value: 500000,
    ),
    FilterObject(
      name: '>= 1.000.000 đ',
      value: 1000000,
    ),
    FilterObject(
      name: '>= 5.000.000 đ',
      value: 5000000,
    ),
    FilterObject(
      name: '>= 10.000.000 đ',
      value: 1000000,
    ),
  ];

  //Tỉnh
  RxString selectProvince = ''.obs;
  List<String> labelProvince = [];

  //Ngày bắt đầu
  late TextEditingController fromDateController;
  late TextEditingController toDateController;
  DateTime? currentFromDate;
  DateTime? currentToDate;

  late GlobalKey<TreeTypeFieldState> treeTypeFieldKey;
  @override
  void onInit() async {
    searchController = TextEditingController();
    treeTypeFieldKey = GlobalKey<TreeTypeFieldState>();
    fromDateController = TextEditingController();
    toDateController = TextEditingController();
    super.onInit();
    _loadWorkTypes();
    _loadTreeTypes();
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
    // print('>>>>Firstime hasNextpage: $_hasNextpage');
    print(
        'hasNextpage: $_hasNextpage; page: $_currentPage; page_size: $_pageSize; is loading value: ${isLoading.value}');
    GetRequestJobPostList data = GetRequestJobPostList(
        status: "2",
        page: (++_currentPage).toString(),
        pageSize: (_pageSize).toString(),
        sortColumn: JobPostSortColumn.createdDate,
        orderBy: SortOrder.descending,
        type: paidTypeFilter, //filter paid type
        startDateFrom:
            currentFromDate != null ? "${currentFromDate!.toLocal()}Z" : '',
        startDateTo:
            currentToDate != null ? "${currentToDate!.toLocal()}Z" : '',
        workTypeId: workTypeId != null ? workTypeId.toString() : ''
     );

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
        // print('>>>is loading value: ${isLoading.value}');
        listObject.addAll(response.listJobPost);
        // print('>>>>second object: ${response.secondObject!.length}');
        // secondObject.addAll(response.secondObject!);

        //Filter again paid type for second Object
        // _filter(response);

        _hasNextpage = response.pagingMetadata.hasNextPage;
        // print('next page: $_hasNextpage; second object: ${secondObject.isEmpty}');
        if (_hasNextpage && secondObject.isEmpty) {
          secondObject.addAll(response.secondObject!);
        }
        // print('list object: ${listObject.length}');
        // print('second object: ${secondObject.length}');
      }
      isLoading.value = false;
      print('>>>$_hasNextpage');
      return true;
    } on CustomException catch (e) {
      isLoading.value = false;
      _hasNextpage = false;
      print('error: $e');
      return null;
    }
  }

  _filter(JobPostResponse response) {
    if (paidTypeFilter != null) {
      // print('paid type: $paidTypeFilter');
      secondObject.addAll(response.secondObject!.where((element) =>
          element.type.toLowerCase() == paidTypeFilter!.toLowerCase()));
      // print('num second object: ${secondObject.length}');
      return;
    }
    secondObject.addAll(response.secondObject!);
  }

  Future<void> onRefresh() async {
    //reset current page & hasNext
    _currentPage = 0;
    _hasNextpage = true;

    //clear list
    listObject.clear();
    secondObject.clear();

    await getListJobPost();

    // update();
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

  //filter
  onClearFilter() {
    paidTypeFilter = null;
    selectedTreeTypes.clear();
    print('select work type: ${selectedTreeTypes.length}');

    selectSalaryRange.value = FilterObject(name: 'Mức lương', value: null);

    selectedWorkTypes.value = '';
    workTypeId = null;
    
    onClearChooseDate();
  }

  onClearChooseDate() {
    currentFromDate = null;
    fromDateController.text = '';
    currentToDate = null;
    toDateController.text = '';
  }

  onApplyFilter() async {
    await onRefresh();
    Get.back(); //close filter page
  }

  void onSalaryRangeChange(String? fo) {
    if (fo != null) {
      selectSalaryRange.value =
          filterSalaryList.firstWhere((element) => element.name == fo);
    }
  }

  void onProvinceChange(String? province) {
    if (province != null) {
      selectProvince.value = province;
    }
  }

  void onWorkTypeChange(String? fo) {
    if (fo != null) {
      selectedWorkTypes.value = fo;
      workTypeId = workTypeList.firstWhere((workType) => workType.name == fo).value;
    }
  }

  void onChooseFromDate() async {
    //clear toDate before choose fromDate
    currentToDate = DateTime.now();
    toDateController.text = '';

    DateTime? firstDate = DateTime.now();
    DateTime? pickedDate = await MyDatePicker.show(
        initDate: currentFromDate,
        firstDate: firstDate,
        lastDate: DateTime.now()
            .add(const Duration(days: 365 * 10))); //check ngày end job
    if (pickedDate != null) {
      currentFromDate = pickedDate;
      fromDateController.text = Utils.formatddMMyyyy(pickedDate);
    }
    print('current from date: $currentFromDate');
  }

  void onChooseToDate() async {
    DateTime? firstDate = currentFromDate;
    DateTime? pickedDate = await MyDatePicker.show(
        initDate: firstDate,
        // currentToDate.isBefore(currentFromDate) ? firstDate : currentToDate,
        firstDate: firstDate,
        lastDate: DateTime.now()
            .add(const Duration(days: 365 * 10))); //check ngày end job
    if (pickedDate != null) {
      currentToDate = pickedDate;
      toDateController.text = Utils.formatddMMyyyy(pickedDate);
    }
  }

  _loadWorkTypes() async {
    GetWorkTypeRequest data =
        GetWorkTypeRequest(page: 1.toString(), pageSize: 100.toString());

    try {
      workTypeResponse = await getList(data);
      if (workTypeResponse != null) {
        final List<WorkType> workTypes = workTypeResponse!.workTypes;
        List<FilterObject> types = workTypes
            .map((type) => FilterObject(name: type.name, value: type.id))
            .toList();
        workTypeList.addAll(types);
        labelWorkType
            .addAll(workTypes.map((workType) => workType.name).toList());
      }
    } on CustomException catch (e) {
      printError(info: 'error in load work type: $e');
    }
  }

  _loadTreeTypes() async {
    GetTreeTypeRequest data = GetTreeTypeRequest(
      page: 1.toString(),
      pageSize: 100.toString(),
      status: TreeTypeStatus.active.index.toString(),
    );

    try {
      final GetTreeTypeResponse? response = await getTreeTypeList(data);

      if (response != null && response.treeTypes != null) {
        final List<TreeType> treeTypelist = response.treeTypes!;
        treeTypes = treeTypelist.obs;
        update();
      }
    } on CustomException catch (e) {
      print('error in farmer controller: ${e.message}');
    }
  }

  // _loadAreas() async {
  //   GetAreaRequest data = GetAreaRequest(
  //     page: '1',
  //     pageSize: '100',
  //     status: '1',
  //     sortColumn: AreaSortColumn.province,
  //     orderBy: SortOrder.ascending,
  //   );

  //   final GetAreaResponse? response = await _areaRepository.getAreas(data);
  //   if (response == null) return;

  //   if (response.areas != null) {
  //     areas.value = response.areas as List<Area>;
  //     loadProvinces();
  //   }
  // }

}
