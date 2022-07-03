import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/fee_data.dart';
import 'package:myray_mobile/app/data/models/garden/garden_models.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post_cru.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_hour_job/pay_per_hour_job.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_task_job/pay_per_task_job.dart';
import 'package:myray_mobile/app/data/models/post_type/post_type_models.dart';
import 'package:myray_mobile/app/data/models/tree_jobs/tree_jobs.dart';
import 'package:myray_mobile/app/data/models/tree_type/tree_type_models.dart';
import 'package:myray_mobile/app/data/services/services.dart';
import 'package:myray_mobile/app/modules/garden/garden_repository.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_controller.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/tree_type_fields.dart';
import 'package:myray_mobile/app/modules/profile/controllers/landowner_profile_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/information_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/controls/my_date_picker.dart';

class JobPostFormController extends GetxController {
  final Activities action = Get.arguments[Arguments.action];

  String get screenTitle => action == Activities.create
      ? AppStrings.titleCreateJobPost
      : AppStrings.titleEditJobPost;

  String get buttonTitle => action == Activities.create
      ? AppStrings.titleCreate
      : AppStrings.titleUpdate;

  final Rx<FeeData> _feeConfig = Rx(FeeData());
  final _userPoint = Get.find<LandownerProfileController>().user.value.point!;

  var postTypeCost = 0.0.obs;
  final _totalFee = 0.0.obs;

  final _gardenRepository = Get.find<GardenRepository>();
  final _treeTypeRepository = Get.find<TreeTypeRepository>();
  final _postTypeRepository = Get.find<PostTypeRepository>();
  final _jobPostRepository = Get.find<JobPostRepository>();
  final _feeDataService = Get.find<FeeDataService>();

  final RxList<Garden> gardens = RxList<Garden>();
  Rx<Garden?> selectedGarden = Rx(null);

  RxList<TreeType>? treeTypes;
  RxList<TreeType> selectedTreeTypes = RxList<TreeType>();

  RxList<PostType>? postTypes;
  Rx<PostType?> selectedPostType = Rx(null);

  var selectedWorkType = ''.obs;
  var isToolAvailable = false.obs;
  var isUpgrade = false.obs;

  var numOfPublishDay = 0.obs;
  var totalPostingMoney = 0.0.obs;
  var usingPoint = 0.obs;
  var totalDiscountByPoint = 0.0.obs;

  var numOfUpgradeDay = 0.obs;
  var upgradeCost = 0.0.obs;

  late GlobalKey<FormState> formKey;
  late GlobalKey<TreeTypeFieldState> treeTypeFieldKey;

  //controller for text fields
  late TextEditingController workNameController;
  late TextEditingController jobStartDateController;
  late TextEditingController descriptionController;
  late TextEditingController publishDateController;
  late TextEditingController numOfPublishDayController;
  late TextEditingController usingPointController;

  //controllers for pay per hour job
  late TextEditingController estimateWorkController;
  late TextEditingController minFarmerController;
  late TextEditingController maxFarmerController;
  late MoneyMaskedTextController hourSalaryController;
  late TextEditingController startHourController;
  late TextEditingController endHourController;

  //controllers for pay per task job
  late MoneyMaskedTextController taskSalaryController;
  late TextEditingController jobEndDateController;

  //controllers for upgrade job
  late TextEditingController upgradeDateController;
  late TextEditingController numOfUpgradeDateController;

  String get numOfPublishDayEquation =>
      '${Utils.vietnameseCurrencyFormat.format(_feeConfig.value.postingFeePerDay)} x '
      '${numOfPublishDay.value} (ngày)';
  String get publishFee =>
      '= ${Utils.vietnameseCurrencyFormat.format(totalPostingMoney.value)}';

  String get usingPointEquation =>
      '${Utils.vietnameseCurrencyFormat.format(_feeConfig.value.pointToReduce1VND)} x ${usingPoint.value} (điểm)';
  String get totalReduce =>
      '= ${Utils.vietnameseCurrencyFormat.format(totalDiscountByPoint.value)}';

  String get upgradeEquation =>
      '${Utils.vietnameseCurrencyFormat.format(postTypeCost.value)} x '
      '${numOfUpgradeDay.value} (ngày)';
  String get totalUpgrade =>
      '= ${Utils.vietnameseCurrencyFormat.format(upgradeCost.value)}';

  String get userPoint => Utils.threeDigitsFormat.format(_userPoint);
  String get totalFee => Utils.vietnameseCurrencyFormat.format(_totalFee.value);
  String get bonusPoint {
    if (_feeConfig.value.pointToReduce1VND != 0) {
      return Utils.threeDigitsFormat
          .format((_totalFee / _feeConfig.value.payToHave1Point).round());
    }

    return '0';
  }

  @override
  void onInit() async {
    formKey = GlobalKey<FormState>();
    treeTypeFieldKey = GlobalKey<TreeTypeFieldState>();

    //create controller for text fields
    workNameController = TextEditingController();
    jobStartDateController = TextEditingController();
    descriptionController = TextEditingController();
    publishDateController = TextEditingController();
    numOfPublishDayController = TextEditingController();
    usingPointController = TextEditingController();

    //create controller for pay per hour job
    estimateWorkController = TextEditingController();
    minFarmerController = TextEditingController();
    maxFarmerController = TextEditingController();
    hourSalaryController = MoneyMaskedTextController(
      thousandSeparator: '.',
      rightSymbol: 'đ/ngày',
      precision: 0,
      decimalSeparator: '',
    );
    startHourController = TextEditingController();
    endHourController = TextEditingController();

    //create controller for pay per task job
    taskSalaryController = MoneyMaskedTextController(
      thousandSeparator: '.',
      rightSymbol: 'đ',
      precision: 0,
      decimalSeparator: '',
    );
    jobEndDateController = TextEditingController();

    //create controller for upgrade job post
    upgradeDateController = TextEditingController();
    numOfUpgradeDateController = TextEditingController();

    //get fee config
    await getFeeConfig();

    //get garden list
    await getGardens();

    //get tree type list
    await getTreeTypes();

    //get post type list
    await getPostTypes();

    super.onInit();
  }

  onSubmitForm() {
    //check form validation
    bool isTreeTypeValid = treeTypeFieldKey.currentState!.validate();
    bool isFormFieldsValid = formKey.currentState!.validate();

    if (!isTreeTypeValid || !isFormFieldsValid) return;

    //check balance
    final _profile = Get.find<LandownerProfileController>();
    if (_totalFee.value > _profile.balanceWithPending.value) {
      InformationDialog.showDialog(
        msg: 'Bạn không đủ tiền trong tài khoản.',
        confirmTitle: AppStrings.titleClose,
      );
      return;
    }

    //execute create or update
    if (action == Activities.create) {
      onCreate();
    } else {}
  }

  onCreate() async {
    EasyLoading.show(status: AppStrings.loading);

    //get data from controller
    JobPostCru data = _createData();

    final JobPost? _newJobPost = await _jobPostRepository.create(data);

    EasyLoading.dismiss();

    print(_newJobPost == null);

    if (_newJobPost == null) {
      //show error
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
      return;
    }

    //refresh job post list
    final _jobPostController = Get.find<LandownerJobPostController>();
    _jobPostController.onRefresh();

    Get.back();

    CustomSnackbar.show(
      title: AppStrings.titleSuccess,
      message: AppMsg.MSG4006,
    );
  }

  JobPostCru _createData() {
    int _gardenId = selectedGarden.value!.id;
    List<TreeJobs> _treeJobs = selectedTreeTypes
        .map((treeType) => TreeJobs(treeTypeId: treeType.id!))
        .toList();
    String _title = workNameController.text;
    DateTime _jobStartDate = Utils.fromddMMyyyy(jobStartDateController.text);
    int _numOfPublishDay = int.parse(numOfPublishDayController.text);
    String _description = descriptionController.text;
    DateTime _publishedDate = Utils.fromddMMyyyy(publishDateController.text);
    DateTime? _jobEndDate;
    PayPerHourJob? _payPerHourJob;
    PayPerTaskJob? _payPerTaskJob;

    if (selectedWorkType.value == AppStrings.payPerTask) {
      _payPerTaskJob = PayPerTaskJob(
        salary: taskSalaryController.numberValue,
        isFarmToolsAvaiable: isToolAvailable.value,
      );

      _jobEndDate = Utils.fromddMMyyyy(jobEndDateController.text);
    } else {
      _payPerHourJob = PayPerHourJob(
        estimatedTotalTask: int.parse(estimateWorkController.text),
        minFarmer: int.parse(minFarmerController.text),
        maxFarmer: int.parse(maxFarmerController.text),
        salary: hourSalaryController.numberValue,
        startTime: startHourController.text,
        finishTime: endHourController.text,
      );
    }

    int _usedPoint = usingPointController.text.isNotEmpty
        ? double.parse(usingPointController.text).round()
        : 0;

    int? _postTypeId = selectedPostType.value?.id;
    DateTime? _pinDate;
    int? _numberOfPinDay;
    if (_postTypeId != null) {
      _pinDate = Utils.fromddMMyyyy(upgradeDateController.text);
      _numberOfPinDay = int.parse(numOfUpgradeDateController.text);
    }

    return JobPostCru(
      gardenId: _gardenId,
      title: _title,
      treeJobs: _treeJobs,
      jobStartDate: _jobStartDate,
      jobEndDate: _jobEndDate,
      numOfPublishDay: _numOfPublishDay,
      publishedDate: _publishedDate,
      description: _description,
      numberOfPinDay: _numberOfPinDay,
      payPerHourJob: _payPerHourJob,
      payPerTaskJob: _payPerTaskJob,
      pinDate: _pinDate,
      postTypeId: _postTypeId,
      usedPoint: _usedPoint,
    );
  }

  getFeeConfig() async {
    final _result = await _feeDataService.getFeeConfig();
    if (_result != null) {
      _feeConfig.value = _result;
      update();
    }
  }

  getGardens() async {
    final int _accountId = AuthCredentials.instance.user!.id!;

    GetGardenRequest data = GetGardenRequest(
      accountId: _accountId.toString(),
      page: GardenStatus.active.index.toString(),
      pageSize: 100.toString(),
      sortColumn: GardenSortColumn.createdDate,
      orderBy: SortOrder.descending,
    );

    final GetGardenResponse? _response =
        await _gardenRepository.getGardens(data);

    if (_response != null && _response.gardens != null) {
      gardens.addAll(_response.gardens!);
    }
  }

  getTreeTypes() async {
    GetTreeTypeRequest data = GetTreeTypeRequest(
      page: 1.toString(),
      pageSize: 100.toString(),
      status: TreeTypeStatus.active.index.toString(),
    );

    final GetTreeTypeResponse? _response =
        await _treeTypeRepository.getList(data);

    if (_response != null && _response.treeTypes != null) {
      final List<TreeType> _treeTypes = _response.treeTypes!;
      treeTypes = _treeTypes.obs;
      update();
      print(treeTypes!.map((type) => type.toJson()).toString());
    }
  }

  getPostTypes() async {
    GetPostTypeRequest data = GetPostTypeRequest(
      page: 1.toString(),
      pageSize: 100.toString(),
      sortColumn: PostTypeSortColumn.price,
      orderBy: SortOrder.ascending,
    );

    final GetPostTypeResponse? _response =
        await _postTypeRepository.getList(data);
    if (_response != null && _response.postTypes != null) {
      final List<PostType> _postTypes = _response.postTypes!;
      postTypes = _postTypes.obs;
      update();
    }
  }

  //functions for garden dropdown list
  bool compareGarden(Garden? g1, Garden? g2) {
    if (g1 != null && g2 != null) {
      return g1.id == g2.id;
    }
    return false;
  }

  String getGardenName(item) {
    return item.name;
  }

  void onGardenChange(Garden? garden) {
    selectedGarden.value = garden;
  }

  //functions for work type dropdown list
  bool compareWorkType(String? s1, String? s2) {
    if (s1 != null && s2 != null) {
      return Utils.equalsUtf8String(s1, s2);
    }
    return false;
  }

  void onWorkTypeChange(String? s) {
    if (s != null) {
      selectedWorkType.value = s;
    }
  }

  //functions for post type dropdown list
  bool comparePostType(PostType? t1, PostType? t2) {
    if (t1 != null && t2 != null) {
      return t1.id == t2.id;
    }
    return false;
  }

  void onPostTypeChange(PostType? postType) {
    selectedPostType.value = postType;
    postTypeCost.value = postType == null ? 0.0 : postType.price;
    calUpgradeCost();
  }

  calTotalFee() {
    _totalFee.value = totalPostingMoney.value +
        upgradeCost.value -
        totalDiscountByPoint.value;
  }

  void calUpgradeCost() {
    upgradeCost.value = postTypeCost.value * numOfUpgradeDay.value;
    calTotalFee();
  }

  //open time picker
  Future<TimeOfDay?> chooseTime({TimeOfDay? initTime}) {
    return showTimePicker(
      context: Get.context!,
      initialTime: initTime ?? TimeOfDay.now(),
      confirmText: 'Chọn'.toUpperCase(),
      cancelText: 'Đóng'.toUpperCase(),
      hourLabelText: 'Giờ',
      minuteLabelText: 'Phút',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }

  //choose start date
  void onChooseStartDate() async {
    DateTime? _initDate = jobStartDateController.text.isEmpty
        ? null
        : Utils.fromddMMyyyy(jobStartDateController.text);
    DateTime? _pickedDate = await MyDatePicker.show(
        initDate: _initDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365 * 10)));
    if (_pickedDate != null) {
      jobStartDateController.text = Utils.formatddMMyyyy(_pickedDate);
    }
  }

  //choose start hour
  void onChooseStartHour() async {
    TimeOfDay? _initTime = startHourController.text.isNotEmpty
        ? Utils.fromHHmm(startHourController.text)
        : null;
    TimeOfDay? _pickedTime = await chooseTime(initTime: _initTime);
    if (_pickedTime != null) {
      String timeFormat = Utils.formatHHmm(_pickedTime);
      startHourController.text = timeFormat;
    }
  }

  //choose start hour
  void onChooseEndHour() async {
    TimeOfDay? _initTime = endHourController.text.isNotEmpty
        ? Utils.fromHHmm(endHourController.text)
        : null;
    TimeOfDay? _pickedTime = await chooseTime(initTime: _initTime);
    if (_pickedTime != null) {
      String timeFormat = Utils.formatHHmm(_pickedTime);
      endHourController.text = timeFormat;
    }
  }

  //choose job end date
  void onChooseJobEndDate() async {
    DateTime now = DateTime.now();
    DateTime _firstDate = jobStartDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(jobStartDateController.text)
        : now;
    DateTime? _initDate = !_firstDate.isAtSameMomentAs(now)
        ? _firstDate
        : jobEndDateController.text.isNotEmpty
            ? Utils.fromddMMyyyy(jobEndDateController.text)
            : null;
    DateTime? _pickedDate = await MyDatePicker.show(
        firstDate: _firstDate,
        initDate: _initDate,
        lastDate: DateTime.now().add(const Duration(days: 365 * 10)));
    if (_pickedDate != null) {
      jobEndDateController.text = Utils.formatddMMyyyy(_pickedDate);
    }
  }

  //choose job end date
  void onChooseUpgradeDate() async {
    DateTime now = DateTime.now();
    DateTime _firstDate = publishDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(publishDateController.text)
        : now;
    DateTime? _initDate = !_firstDate.isAtSameMomentAs(now)
        ? _firstDate
        : upgradeDateController.text.isNotEmpty
            ? Utils.fromddMMyyyy(upgradeDateController.text)
            : null;
    DateTime? _lastDate = numOfPublishDayController.text.isNotEmpty &&
            publishDateController.text.isNotEmpty
        ? _firstDate
            .add(Duration(days: int.parse(numOfPublishDayController.text) - 1))
        : DateTime.now().add(const Duration(days: 365 * 10));
    DateTime? _pickedDate = await MyDatePicker.show(
      firstDate: _firstDate,
      initDate: _initDate,
      lastDate: _lastDate,
    );
    if (_pickedDate != null) {
      upgradeDateController.text = Utils.formatddMMyyyy(_pickedDate);
    }
  }

  //choose job publish date
  void onChoosePublishDate() async {
    DateTime now = DateTime.now();

    //the publish date cannot be today if created time after 4 p.m. in the same date
    DateTime _firstDate = now.hour >= 16 && now.hour <= 23
        ? now.add(const Duration(days: 1))
        : now;
    DateTime? _initDate = publishDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(publishDateController.text)
        : _firstDate;
    DateTime? _pickedDate = await MyDatePicker.show(
        initDate: _initDate,
        firstDate: _firstDate,
        lastDate: DateTime.now().add(const Duration(days: 365 * 10)));
    if (_pickedDate != null) {
      publishDateController.text = Utils.formatddMMyyyy(_pickedDate);
    }
  }

  //handle onChange number of publish day
  void onChangeNumOfPublishDay(String value) {
    if (value.isEmpty || !Utils.isPositiveInteger(value)) {
      numOfPublishDay.value = 0;
    } else {
      numOfPublishDay.value = int.parse(value);
    }
    totalPostingMoney.value =
        _feeConfig.value.postingFeePerDay * numOfPublishDay.value;
    calTotalFee();
  }

  void onChangeUsingPoint(String value) {
    if (value.isEmpty || !Utils.isPositiveInteger(value)) {
      usingPoint.value = 0;
    } else {
      usingPoint.value = int.parse(value);
    }
    totalDiscountByPoint.value =
        _feeConfig.value.pointToReduce1VND * usingPoint.value;
    calTotalFee();
  }

  void onChangeNumOfUpgradeDay(String value) {
    if (value.isEmpty) {
      numOfUpgradeDay.value = 0;
    } else {
      numOfUpgradeDay.value = int.parse(value);
    }
    calUpgradeCost();
  }

  //fields validation
  String? validateWorkName(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    return null;
  }

  String? validateGardenSelection(Garden? garden) {
    if (garden == null) return AppMsg.MSG0002;
    return null;
  }

  String? validateWorkType(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    return null;
  }

  String? validateJobStartDate(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    //start date must be after publish date
    DateTime startDate = Utils.fromddMMyyyy(value!);

    if (publishDateController.text.isNotEmpty) {
      DateTime publishDate = Utils.fromddMMyyyy(publishDateController.text);
      if (startDate.compareTo(publishDate) <= 0) {
        return 'Ngày bắt đầu công việc phải sau ngày đăng bài';
      }
    }

    if (selectedWorkType.value == AppStrings.payPerTask &&
        jobEndDateController.text.isNotEmpty) {
      DateTime endDate = Utils.fromddMMyyyy(jobEndDateController.text);
      if (startDate.compareTo(endDate) >= 0) {
        return 'Ngày bắt đầu phải trước ngày kết thúc';
      }
    }

    return null;
  }

  String? validateUsingPoint(String? value) {
    if (Utils.isEmpty(value)) {
      return null;
    }

    if (!Utils.isPositiveInteger(value!)) {
      return AppMsg.MSG0010;
    }

    //check user point is enough or not
    if (int.parse(value) > _userPoint) {
      return 'Điểm của bạn không đủ';
    }

    return null;
  }

  String? validateEstimateWork(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    if (!Utils.isPositiveInteger(value!)) {
      return AppMsg.MSG0010;
    }

    return null;
  }

  String? validateMinFarmer(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    if (!Utils.isPositiveInteger(value!)) {
      return AppMsg.MSG0010;
    }

    int? max = int.tryParse(maxFarmerController.text);
    int min = int.parse(value);
    if (max != null && min > max) {
      return 'Số người tối thiểu phải nhỏ hơn số người tối đa';
    }

    return null;
  }

  String? validateMaxFarmer(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    if (!Utils.isPositiveInteger(value!)) {
      return AppMsg.MSG0010;
    }

    int? min = int.tryParse(minFarmerController.text);
    int max = int.parse(value);
    if (min != null && max < min) {
      return 'Số người tối đa phải lớn hơn số người tối thiểu';
    }

    return null;
  }

  String? validateHourSalary(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    if (hourSalaryController.numberValue <= 0) {
      return AppMsg.MSG0010;
    }

    return null;
  }

  String? validateStartHour(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    return null;
  }

  String? validateEndHour(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    return null;
  }

  String? validateTaskSalary(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    if (taskSalaryController.numberValue <= 0) {
      return AppMsg.MSG0010;
    }

    return null;
  }

  String? validateJobEndDate(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    //job end date must after job start date
    DateTime endDate = Utils.fromddMMyyyy(value!);
    if (jobStartDateController.text.isNotEmpty) {
      DateTime startDate = Utils.fromddMMyyyy(jobStartDateController.text);
      if (startDate.compareTo(endDate) >= 0) {
        return 'Ngày kết thúc công việc phải sau ngày bắt đầu';
      }
    }

    return null;
  }

  String? validatePostType(PostType? postType) {
    if (postType == null) return AppMsg.MSG0002;
    return null;
  }

  String? validateUpgradeDate(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    //upgrade date must be after or at the same time as publish date
    DateTime upgradeDate = Utils.fromddMMyyyy(value!);
    if (publishDateController.text.isNotEmpty) {
      DateTime publishDate = Utils.fromddMMyyyy(publishDateController.text);
      if (publishDate.compareTo(upgradeDate) > 0) {
        return 'Ngày nâng cấp phải cùng hoặc sau ngày đăng bài';
      }
    }

    return null;
  }

  String? validateNumOfUpgradeDay(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    //check upgrade date
    if (upgradeDateController.text.isNotEmpty &&
        numOfPublishDayController.text.isNotEmpty &&
        publishDateController.text.isNotEmpty &&
        isUpgrade.value) {
      DateTime endUpradeDate = Utils.fromddMMyyyy(upgradeDateController.text)
          .add(Duration(days: int.parse(value!)));
      DateTime endPublishDate = Utils.fromddMMyyyy(publishDateController.text)
          .add(Duration(days: int.parse(numOfPublishDayController.text)));
      Duration difference = endPublishDate.difference(endUpradeDate);
      if (difference.inDays < 0) {
        return 'Ngày nâng cấp không hợp lệ';
      }
    }
    return null;
  }

  String? validatePublishDate(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    DateTime publishDate = Utils.fromddMMyyyy(value!);

    //publish date must be before start date
    if (jobStartDateController.text.isNotEmpty) {
      DateTime startDate = Utils.fromddMMyyyy(jobStartDateController.text);

      if (startDate.compareTo(publishDate) <= 0) {
        return 'Ngày đăng bài phải trước ngày bắt đầu công việc';
      }
    }

    return null;
  }

  String? validateNumOfPublishDay(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    if (!Utils.isPositiveInteger(value!)) {
      return AppMsg.MSG0010;
    }

    return null;
  }
}
