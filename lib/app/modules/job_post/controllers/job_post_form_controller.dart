import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/fee_data.dart';
import 'package:myray_mobile/app/data/models/garden/garden_models.dart';
import 'package:myray_mobile/app/data/models/job_post/check_pin_date_request.dart';
import 'package:myray_mobile/app/data/models/job_post/get_max_pin_day_request.dart';
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
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_details_controller.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/tree_type_fields.dart';
import 'package:myray_mobile/app/modules/profile/controllers/landowner_profile_controller.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/information_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/controls/my_date_picker.dart';

class JobPostFormController extends GetxController {
  final Activities action = Get.arguments[Arguments.action];
  final JobPost? _jobPost = Get.arguments[Arguments.item];

  String get screenTitle => action == Activities.create
      ? AppStrings.titleCreateJobPost
      : AppStrings.titleEditJobPost;

  String get buttonTitle => action == Activities.create
      ? AppStrings.titleCreate
      : AppStrings.titleUpdate;

  final Rx<FeeData> _feeConfig = Rx(FeeData());
  int _userPoint =
      Get.find<LandownerProfileController>().pointWithPending.value;

  late double _userBalance;

  var postTypeCost = 0.0.obs;
  final _totalFee = 0.0.obs;

  final _gardenRepository = Get.find<GardenRepository>();
  final _treeTypeRepository = Get.find<TreeTypeRepository>();
  final _postTypeRepository = Get.find<PostTypeRepository>();
  final _jobPostRepository = Get.find<JobPostRepository>();
  final _feeDataService = Get.find<FeeDataService>();
  final _profile = Get.find<LandownerProfileController>();

  final List<DateTime> availablePinDates = [];

  final RxList<Garden> gardens = RxList<Garden>();
  Rx<Garden?> selectedGarden = Rx(null);

  RxList<TreeType>? treeTypes;
  RxList<TreeType> selectedTreeTypes = RxList<TreeType>();

  RxList<PostType>? postTypes;
  Rx<PostType?> selectedPostType = Rx(null);

  var selectedWorkType = ''.obs;
  var isToolAvailable = false.obs;
  var isUpgrade = false.obs;

  var numOfPublishDay = 3.obs;
  var totalPostingMoney = 0.0.obs;
  var usingPoint = 0.obs;
  var totalDiscountByPoint = 0.0.obs;

  var numOfUpgradeDay = 0.obs;
  var upgradeCost = 0.0.obs;
  var isEnableDayEdit = false.obs;
  var maxDay = 0.obs;

  late GlobalKey<FormState> formKey;
  late GlobalKey<TreeTypeFieldState> treeTypeFieldKey;

  //controller for text fields
  late TextEditingController workNameController;
  late TextEditingController jobStartDateController;
  late TextEditingController descriptionController;
  late TextEditingController publishDateController;
  // late TextEditingController numOfPublishDayController;
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
  // late TextEditingController numOfUpgradeDateController;

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

    _userBalance =
        Get.find<LandownerProfileController>().balanceWithPending.value;

    //create controller for text fields
    workNameController = TextEditingController();
    jobStartDateController = TextEditingController();
    descriptionController = TextEditingController();
    publishDateController = TextEditingController();
    usingPointController = TextEditingController();

    //create controller for pay per hour job
    estimateWorkController = TextEditingController();
    minFarmerController = TextEditingController();
    maxFarmerController = TextEditingController();
    hourSalaryController = MoneyMaskedTextController(
      thousandSeparator: '.',
      rightSymbol: 'đ/công',
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

    //get fee config
    await getFeeConfig();

    //get garden list
    await getGardens();

    //get tree type list
    await getTreeTypes();

    //get post type list
    await getPostTypes();

    calPostingFee();
    calTotalFee();

    if (_jobPost != null) {
      loadData();
    }

    super.onInit();
  }

  onSubmitForm() {
    //check form validation
    bool isTreeTypeValid = treeTypeFieldKey.currentState!.validate();
    bool isFormFieldsValid = formKey.currentState!.validate();

    if (!isTreeTypeValid || !isFormFieldsValid) return;

    //check balance
    if (_totalFee.value > _userBalance) {
      InformationDialog.showDialog(
        msg: 'Bạn không đủ tiền trong tài khoản.',
        confirmTitle: AppStrings.titleClose,
      );
      return;
    }

    //execute create or update
    if (action == Activities.create) {
      onCreate();
    } else {
      onUpdate();
    }
  }

  //load data for update form
  loadData() async {
    workNameController.text = _jobPost?.title ?? '';
    jobStartDateController.text = _jobPost?.jobStartDate != null
        ? Utils.formatddMMyyyy(_jobPost!.jobStartDate)
        : '';
    descriptionController.text = _jobPost?.description ?? '';
    publishDateController.text = _jobPost?.publishedDate != null
        ? Utils.formatddMMyyyy(_jobPost!.publishedDate)
        : '';
    numOfPublishDay.value = _jobPost?.numOfPublishDay ?? 3;

    //get payment history from job post details controller

    final detailsController = Get.find<LandownerJobPostDetailsController>(
        tag: Get.arguments[Arguments.tag]);

    usingPointController.text =
        detailsController.paymentHistories.first.usedPoint?.toString() ?? '0';
    usingPoint.value = detailsController.paymentHistories.first.usedPoint ?? 0;

    _userPoint += detailsController.paymentHistories.first.usedPoint!;
    _userBalance += detailsController.paymentHistories.first.actualPrice!;

    //pay per hour job
    if (_jobPost!.payPerHourJob != null) {
      final PayPerHourJob hourJob = _jobPost!.payPerHourJob!;
      estimateWorkController.text = hourJob.estimatedTotalTask.toString();
      minFarmerController.text = hourJob.minFarmer.toString();
      maxFarmerController.text = hourJob.maxFarmer.toString();
      hourSalaryController.updateValue(hourJob.salary);
      selectedWorkType.value = AppStrings.payPerHour;
      startHourController.text = Utils.getHHmm(hourJob.startTime);
      endHourController.text = Utils.getHHmm(hourJob.finishTime);
    }

    //pay per task job
    if (_jobPost!.payPerTaskJob != null) {
      final PayPerTaskJob taskJob = _jobPost!.payPerTaskJob!;
      jobEndDateController.text = _jobPost?.jobEndDate != null
          ? Utils.formatddMMyyyy(_jobPost!.jobEndDate!)
          : '';
      taskSalaryController.updateValue(taskJob.salary);
      isToolAvailable.value = taskJob.isFarmToolsAvaiable ?? false;
      selectedWorkType.value = AppStrings.payPerTask;
    }

    //set selected garden
    selectedGarden.value =
        gardens.firstWhere((element) => element.id == _jobPost!.gardenId);

    selectedTreeTypes = _jobPost!.treeJobs
        .map((treeJob) =>
            TreeType(id: treeJob.treeTypeId, status: 1, type: treeJob.type!))
        .toList()
        .cast<TreeType>()
        .obs;

    //load upgrade post info
    if (_jobPost?.postTypeId != null) {
      selectedPostType = postTypes!
          .firstWhere((element) => element.id == _jobPost!.postTypeId)
          .obs;
      isUpgrade.value = true;
      upgradeDateController.text = _jobPost?.pinStartDate != null
          ? Utils.formatddMMyyyy(_jobPost!.pinStartDate!)
          : '';
      numOfUpgradeDay.value = _jobPost?.totalPinDay ?? 0;
      isEnableDayEdit.value = true;
      postTypeCost.value =
          detailsController.paymentHistories.first.postTypePrice!;
      await getAvailablePinDates();
      await getMaxPinDay();
    }

    calPoint();
    calPostingFee();
    calUpgradeCost();
  }

  onUpdate() async {
    EasyLoading.show(status: AppStrings.loading);

    //get data from controller
    JobPostCru data = _createData()..id = _jobPost!.id;

    try {
      final JobPost? updatedJobPost = await _jobPostRepository.update(data);
      EasyLoading.dismiss();

      if (updatedJobPost == null) {
        //show error
        CustomSnackbar.show(
          title: AppStrings.titleError,
          message: 'Có lỗi xảy ra',
          backgroundColor: AppColors.errorColor,
        );
        return;
      }

      //refresh job post details screen
      final detailsController = Get.find<LandownerJobPostDetailsController>(
          tag: Get.arguments[Arguments.tag]);
      detailsController.jobPost.value = updatedJobPost;

      //Update job post list
      final jobPostController = Get.find<LandownerJobPostController>();
      final jobPosts = jobPostController.jobPosts;
      int index = jobPosts.indexWhere((job) => job.id == updatedJobPost.id);
      jobPosts[index] = updatedJobPost;

      //update payment history
      await detailsController.getPaymentHistory();

      //refresh balance
      await _profile.calBalance();

      Get.back();

      CustomSnackbar.show(
        title: AppStrings.titleSuccess,
        message: 'Cập nhật thành công',
      );
    } on Exception {
      EasyLoading.dismiss();
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  onCreate() async {
    EasyLoading.show(status: AppStrings.loading);

    //get data from controller
    JobPostCru data = _createData();

    try {
      final JobPost? newJobPost = await _jobPostRepository.create(data);
      EasyLoading.dismiss();

      if (newJobPost == null) {
        //show error
        CustomSnackbar.show(
          title: AppStrings.titleError,
          message: 'Có lỗi xảy ra',
          backgroundColor: AppColors.errorColor,
        );
        return;
      }

      //refresh job post list
      final jobPostController = Get.find<LandownerJobPostController>();
      jobPostController.onRefresh();

      //refresh balance
      _profile.calBalance();

      Get.back();

      CustomSnackbar.show(
        title: AppStrings.titleSuccess,
        message: AppMsg.MSG4006,
      );
    } on Exception {
      EasyLoading.dismiss();
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  JobPostCru _createData() {
    int _gardenId = selectedGarden.value!.id;
    List<TreeJobs> _treeJobs = selectedTreeTypes
        .map((treeType) => TreeJobs(treeTypeId: treeType.id!))
        .toList();
    String _title = workNameController.text;
    DateTime _jobStartDate = Utils.fromddMMyyyy(jobStartDateController.text);
    int _numOfPublishDay = numOfPublishDay.value;
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
      _numberOfPinDay = numOfUpgradeDay.value;
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

    final GetGardenResponse? response =
        await _gardenRepository.getGardens(data);

    if (response != null && response.gardens != null) {
      gardens.addAll(response.gardens!);
    }
  }

  getTreeTypes() async {
    GetTreeTypeRequest data = GetTreeTypeRequest(
      page: 1.toString(),
      pageSize: 100.toString(),
      status: TreeTypeStatus.active.index.toString(),
    );

    final GetTreeTypeResponse? response =
        await _treeTypeRepository.getList(data);

    if (response != null && response.treeTypes != null) {
      final List<TreeType> _treeTypes = response.treeTypes!;
      treeTypes = _treeTypes.obs;
      update();
    }
  }

  getPostTypes() async {
    GetPostTypeRequest data = GetPostTypeRequest(
      page: 1.toString(),
      pageSize: 100.toString(),
      sortColumn: PostTypeSortColumn.price,
      orderBy: SortOrder.ascending,
    );

    final GetPostTypeResponse? response =
        await _postTypeRepository.getList(data);
    if (response != null && response.postTypes != null) {
      final List<PostType> _postTypes = response.postTypes!;
      postTypes = _postTypes.obs;
      update();
    }
  }

  bool isUpgradeDateAvailable() {
    if (publishDateController.text.isEmpty || selectedPostType.value == null) {
      return false;
    }

    return true;
  }

  void isNumOfUpgradeDateAvailable() {
    if (isUpgradeDateAvailable() && upgradeDateController.text.isNotEmpty) {
      isEnableDayEdit.value = true;
    } else {
      isEnableDayEdit.value = false;
    }
  }

  resetUpgradeData() {
    selectedPostType = Rx(null);
    upgradeDateController.text = '';
    numOfUpgradeDay.value = 0;
  }

  getAvailablePinDates() async {
    if (!isUpgradeDateAvailable() || !isUpgrade.value) return;

    //clear current list
    availablePinDates.clear();

    final data = CheckPinDateRequest(
      publishedDate: Utils.fromddMMyyyy(publishDateController.text),
      numOfPublishDay: numOfPublishDay.value.toString(),
      postTypeId: selectedPostType.value!.id.toString(),
    );

    List<DateTime>? _pinDates =
        await _jobPostRepository.getAvailablePinDates(data);
    if (_pinDates != null) {
      availablePinDates.addAll(_pinDates);
    }
  }

  viewGardenDetails() {
    //get garden by id
    Garden garden =
        gardens.firstWhere((garden) => garden.id == selectedGarden.value!.id);

    Get.toNamed(Routes.gardenDetails, arguments: {
      Arguments.tag: garden.id.toString(),
      Arguments.item: garden,
      Arguments.action: Activities.view,
    });
  }

  //functions for garden dropdown list
  bool compareGarden(Garden? g1, Garden? g2) {
    if (g1 != null && g2 != null) {
      return g1.id == g2.id;
    }
    return false;
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
    getAvailablePinDates();
    getMaxPinDay();
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
    DateTime? initDate = jobStartDateController.text.isEmpty
        ? null
        : Utils.fromddMMyyyy(jobStartDateController.text);
    DateTime? pickedDate = await MyDatePicker.show(
        initDate: initDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365 * 10)));
    if (pickedDate != null) {
      jobStartDateController.text = Utils.formatddMMyyyy(pickedDate);
    }
  }

  //choose start hour
  void onChooseStartHour() async {
    TimeOfDay? initTime = startHourController.text.isNotEmpty
        ? Utils.fromHHmm(startHourController.text)
        : null;
    TimeOfDay? pickedTime = await chooseTime(initTime: initTime);
    if (pickedTime != null) {
      String timeFormat = Utils.formatHHmm(pickedTime);
      startHourController.text = timeFormat;
    }
  }

  //choose start hour
  void onChooseEndHour() async {
    TimeOfDay? initTime = endHourController.text.isNotEmpty
        ? Utils.fromHHmm(endHourController.text)
        : null;
    TimeOfDay? pickedTime = await chooseTime(initTime: initTime);
    if (pickedTime != null) {
      String timeFormat = Utils.formatHHmm(pickedTime);
      endHourController.text = timeFormat;
    }
  }

  //choose job end date
  void onChooseJobEndDate() async {
    DateTime now = DateTime.now();
    DateTime firstDate = jobStartDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(jobStartDateController.text)
        : now;
    DateTime? initDate = !firstDate.isAtSameMomentAs(now)
        ? firstDate
        : jobEndDateController.text.isNotEmpty
            ? Utils.fromddMMyyyy(jobEndDateController.text)
            : null;
    DateTime? pickedDate = await MyDatePicker.show(
        firstDate: firstDate,
        initDate: initDate,
        lastDate: DateTime.now().add(const Duration(days: 365 * 10)));
    if (pickedDate != null) {
      jobEndDateController.text = Utils.formatddMMyyyy(pickedDate);
    }
  }

  //choose job end date
  void onChooseUpgradeDate() async {
    if (availablePinDates.isEmpty) {
      InformationDialog.showDialog(
        msg:
            'Không có ngày pin phù hợp cho gói nâng cấp này vào những ngày bạn chọn',
        confirmTitle: AppStrings.titleClose,
      );
      return;
    }

    DateTime firstDate = availablePinDates[0];
    DateTime initDate = upgradeDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(upgradeDateController.text)
        : firstDate;
    DateTime lastDate = availablePinDates[availablePinDates.length - 1];
    DateTime? pickedDate = await MyDatePicker.show(
      firstDate: firstDate,
      initDate: initDate,
      lastDate: lastDate,
      selectableDayPredicate: (date) => availablePinDates.contains(date),
    );
    if (pickedDate != null) {
      upgradeDateController.text = Utils.formatddMMyyyy(pickedDate);
      isNumOfUpgradeDateAvailable();
      await getMaxPinDay();
    }
  }

  //choose job publish date
  void onChoosePublishDate() async {
    DateTime now = DateTime.now();

    // the publish date cannot be today if created time after 4 p.m. in the same date
    DateTime firstDate = now.hour >= 16 && now.hour <= 23
        ? now.add(const Duration(days: 1))
        : now;
    DateTime? initDate = publishDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(publishDateController.text)
        : firstDate;
    DateTime? pickedDate = await MyDatePicker.show(
        initDate: initDate,
        firstDate: firstDate,
        lastDate: DateTime.now().add(const Duration(days: 365 * 10)));
    if (pickedDate != null) {
      publishDateController.text = Utils.formatddMMyyyy(pickedDate);
    }
  }

  calPostingFee() {
    totalPostingMoney.value =
        _feeConfig.value.postingFeePerDay * numOfPublishDay.value;
  }

  //handle onChange number of publish day
  void onChangeNumOfPublishDay(double value) {
    numOfPublishDay.value = value.toInt();

    calPostingFee();
    calTotalFee();
    getAvailablePinDates();
  }

  calPoint() {
    totalDiscountByPoint.value =
        _feeConfig.value.pointToReduce1VND * usingPoint.value;
  }

  void onChangeUsingPoint(String value) {
    if (value.isEmpty || !Utils.isPositiveInteger(value)) {
      usingPoint.value = 0;
    } else {
      usingPoint.value = int.parse(value);
    }
    calPoint();
    calTotalFee();
  }

  void onChangeNumOfUpgradeDay(double value) {
    numOfUpgradeDay.value = value.toInt();
    calUpgradeCost();
  }

  getMaxPinDay() async {
    if (upgradeDateController.text.isEmpty) return;
    final data = GetMaxPinDayRequest(
      pinDate: Utils.fromddMMyyyy(upgradeDateController.text),
      numOfPublishDay: numOfPublishDay.value.toString(),
      postTypeId: selectedPostType.value!.id.toString(),
    );
    maxDay.value = await _jobPostRepository.getMaxPinDay(data);
  }

  void onChangeUpgradePost(bool? value) {
    if (!isUpgrade.value && publishDateController.text.isEmpty) {
      InformationDialog.showDialog(
        msg: 'Vui lòng nhập ngày đăng trước',
        confirmTitle: AppStrings.titleClose,
      );
      return;
    }
    isUpgrade.value = value!;
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
      if (startDate.compareTo(endDate) > 0) {
        return 'Ngày bắt đầu phải trước hoặc giống ngày kết thúc';
      }
    }

    return null;
  }

  String? validateUsingPoint(String? value) {
    if (Utils.isEmpty(value)) {
      return null;
    }

    if (!Utils.isInteger(value!)) {
      return 'Vui lòng nhập số nguyên';
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
      if (startDate.compareTo(endDate) > 0) {
        return 'Ngày kết thúc công việc phải sau hoặc giống ngày bắt đầu';
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
    if (!Utils.isPositiveInteger(value!)) {
      return AppMsg.MSG0010;
    }

    //check upgrade date
    if (upgradeDateController.text.isNotEmpty &&
        publishDateController.text.isNotEmpty &&
        isUpgrade.value) {
      DateTime endUpradeDate = Utils.fromddMMyyyy(upgradeDateController.text)
          .add(Duration(days: int.parse(value)));
      DateTime endPublishDate = Utils.fromddMMyyyy(publishDateController.text)
          .add(Duration(days: numOfPublishDay.value));
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

    if (int.parse(value) < 3) {
      return AppMsg.MSG4004;
    }

    return null;
  }
}
