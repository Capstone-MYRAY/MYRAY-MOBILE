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
import 'package:myray_mobile/app/data/models/work_type/work_type_models.dart';
import 'package:myray_mobile/app/data/services/services.dart';
import 'package:myray_mobile/app/data/services/work_type_repository.dart';
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
import 'package:myray_mobile/app/shared/widgets/controls/my_date_range_picker.dart';
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

  var postTypeCost = 0.0.obs;
  final _totalFee = 0.0.obs;

  final _gardenRepository = Get.find<GardenRepository>();
  final _treeTypeRepository = Get.find<TreeTypeRepository>();
  final _postTypeRepository = Get.find<PostTypeRepository>();
  final _jobPostRepository = Get.find<JobPostRepository>();
  final _feeDataService = Get.find<FeeDataService>();
  final _profile = Get.find<LandownerProfileController>();
  final _workTypeRepository = Get.find<WorkTypeRepository>();

  // final List<DateTime> availablePinDates = [];

  LandownerJobPostDetailsController get detailsController =>
      Get.find<LandownerJobPostDetailsController>(
          tag: Get.arguments[Arguments.tag]);

  final RxList<Garden> gardens = RxList<Garden>();
  Rx<Garden?> selectedGarden = Rx(null);

  final RxList<WorkType> workTypes = RxList<WorkType>();
  Rx<WorkType?> selectedWorkType = Rx(null);

  RxList<TreeType>? treeTypes;
  RxList<TreeType> selectedTreeTypes = RxList<TreeType>();

  RxList<PostType>? postTypes;
  Rx<PostType?> selectedPostType = Rx(null);

  var selectedWorkPayType = ''.obs;
  var isToolAvailable = false.obs;
  var isUpgrade = false.obs;

  // var numOfPublishDay = 1.obs;
  var totalPostingMoney = 0.0.obs;
  var usingPoint = 0.obs;
  var totalDiscountByPoint = 0.0.obs;

  var numOfUpgradeDay = 0.obs;
  var upgradeCost = 0.0.obs;
  // var isEnableDayEdit = false.obs;
  // var maxDay = 0.obs;

  DateTimeRange? selectedUpgradedRange;

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

  // String get numOfPublishDayEquation =>
  //     '${Utils.vietnameseCurrencyFormat.format(_feeConfig.value.postingFeePerDay)} x '
  //     '${numOfPublishDay.value} (ngày)';
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

  double get _userBalance =>
      Get.find<LandownerProfileController>().balanceWithPending.value;

  Future<void> loadInitData() async {
    //get fee config
    await getFeeConfig();

    //get garden list
    await getGardens();

    //get tree type list
    await getTreeTypes();

    //get post type list
    await getPostTypes();

    //get work type
    await getWorkType();

    loadData();
  }

  @override
  void onInit() {
    super.onInit();

    formKey = GlobalKey<FormState>();
    treeTypeFieldKey = GlobalKey<TreeTypeFieldState>();

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

    // calPostingFee();
  }

  onSubmitForm() {
    //check form validation
    // bool isTreeTypeValid = treeTypeFieldKey.currentState!.validate();
    bool isFormFieldsValid = formKey.currentState!.validate();

    if (!isFormFieldsValid) return;

    //check balance
    double balance = _userBalance;
    if (action == Activities.update) {
      balance += detailsController.paymentHistories.first.actualPrice!;
    }

    if (_totalFee.value > balance) {
      InformationDialog.showDialog(
        msg:
            'Tiền trong tài khoản còn ${Utils.vietnameseCurrencyFormat.format(_userBalance)} không đủ thực hiện giao dịch.',
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
  loadData() {
    if (_jobPost == null) return;

    workNameController.text = _jobPost?.title ?? '';
    jobStartDateController.text = _jobPost?.jobStartDate != null
        ? Utils.formatddMMyyyy(_jobPost!.jobStartDate)
        : '';
    descriptionController.text = _jobPost?.description ?? '';
    publishDateController.text = _jobPost?.publishedDate != null
        ? Utils.formatddMMyyyy(_jobPost!.publishedDate)
        : '';
    // numOfPublishDay.value = _jobPost?.numOfPublishDay ?? 1;

    //get payment history from job post details controller

    usingPointController.text =
        detailsController.paymentHistories.first.usedPoint?.toString() ?? '0';
    usingPoint.value = detailsController.paymentHistories.first.usedPoint ?? 0;

    _userPoint += detailsController.paymentHistories.first.usedPoint!;

    //pay per hour job
    if (_jobPost!.payPerHourJob != null) {
      final PayPerHourJob hourJob = _jobPost!.payPerHourJob!;
      estimateWorkController.text = hourJob.estimatedTotalTask.toString();
      minFarmerController.text = hourJob.minFarmer.toString();
      maxFarmerController.text = hourJob.maxFarmer.toString();
      hourSalaryController.updateValue(hourJob.salary);
      selectedWorkPayType.value = AppStrings.payPerHour;
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
      selectedWorkPayType.value = AppStrings.payPerTask;
    }

    //set selected garden
    selectedGarden.value =
        gardens.firstWhere((element) => element.id == _jobPost!.gardenId);

    //set selected work type
    selectedWorkType.value =
        workTypes.firstWhere((element) => element.id == _jobPost!.workTypeId);

    if (_jobPost!.treeJobs != null && _jobPost!.treeJobs!.isNotEmpty) {
      selectedTreeTypes = _jobPost!.treeJobs!
          .map((treeJob) =>
              TreeType(id: treeJob.treeTypeId, status: 1, type: treeJob.type!))
          .toList()
          .cast<TreeType>()
          .obs;
    }

    //load upgrade post info
    if (_jobPost?.postTypeId != null) {
      selectedPostType = postTypes!
          .firstWhere((element) => element.id == _jobPost!.postTypeId)
          .obs;

      isUpgrade.value = true;

      numOfUpgradeDay.value = _jobPost?.totalPinDay ?? 0;

      DateTime start = _jobPost!.pinStartDate!.toLocal();
      DateTime end = start.add(Duration(days: numOfUpgradeDay.value - 1));

      selectedUpgradedRange = DateTimeRange(start: start, end: end);

      // upgradeDateController.text = _jobPost?.pinStartDate != null
      //     ? Utils.formatddMMyyyy(_jobPost!.pinStartDate!)
      //     : '';

      if (selectedUpgradedRange!.start
          .isAtSameMomentAs(selectedUpgradedRange!.end)) {
        upgradeDateController.text =
            Utils.formatddMMyyyy(selectedUpgradedRange!.start);
      } else {
        upgradeDateController.text =
            '${Utils.formatddMMyyyy(selectedUpgradedRange!.start)} - ${Utils.formatddMMyyyy(selectedUpgradedRange!.end)}';
      }

      // isEnableDayEdit.value = true;
      postTypeCost.value =
          detailsController.paymentHistories.first.postTypePrice!;
      // await getAvailablePinDates();
      // await getMaxPinDay();
    }

    calUpgradeCost();
    calPoint();
    // calPostingFee();
    calTotalFee();
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
      detailsController.jobPost.value = updatedJobPost;

      //Update job post list
      final jobPostController = Get.find<LandownerJobPostController>();
      final jobPosts = jobPostController.jobPosts;
      int index = jobPosts.indexWhere((job) => job.id == updatedJobPost.id);
      if (index >= 0) {
        jobPosts[index] = updatedJobPost;
      }

      //update payment history
      await detailsController.getPaymentHistory();

      //refresh balance
      await _profile.calBalance();

      //update UI
      detailsController.updateDetails();

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
    int gardenId = selectedGarden.value!.id;
    List<TreeJobs> treeJobs = selectedTreeTypes
        .map((treeType) => TreeJobs(treeTypeId: treeType.id!))
        .toList();
    String title = workNameController.text;
    DateTime jobStartDate = Utils.fromddMMyyyy(jobStartDateController.text);
    // int _numOfPublishDay = numOfPublishDay.value;
    String description = descriptionController.text;
    DateTime publishedDate = Utils.fromddMMyyyy(publishDateController.text);
    DateTime? jobEndDate;
    PayPerHourJob? payPerHourJob;
    PayPerTaskJob? payPerTaskJob;

    if (selectedWorkPayType.value == AppStrings.payPerTask) {
      payPerTaskJob = PayPerTaskJob(
        salary: taskSalaryController.numberValue,
        isFarmToolsAvaiable: isToolAvailable.value,
      );

      jobEndDate = Utils.fromddMMyyyy(jobEndDateController.text);
    } else {
      payPerHourJob = PayPerHourJob(
        estimatedTotalTask: int.parse(estimateWorkController.text),
        minFarmer: int.parse(minFarmerController.text),
        maxFarmer: int.parse(maxFarmerController.text),
        salary: hourSalaryController.numberValue,
        startTime: startHourController.text,
        finishTime: endHourController.text,
      );
    }

    int usedPoint = usingPointController.text.isNotEmpty
        ? double.parse(usingPointController.text).round()
        : 0;

    int? postTypeId = selectedPostType.value?.id;
    DateTime? pinDate;
    int? numberOfPinDay;
    if (postTypeId != null) {
      pinDate = selectedUpgradedRange?.start;
      numberOfPinDay = numOfUpgradeDay.value;
    }

    return JobPostCru(
      gardenId: gardenId,
      title: title,
      treeJobs: treeJobs,
      jobStartDate: jobStartDate,
      jobEndDate: jobEndDate,
      // numOfPublishDay: _numOfPublishDay,
      publishedDate: publishedDate,
      workTypeId: selectedWorkType.value?.id,
      description: description,
      numberOfPinDay: numberOfPinDay,
      payPerHourJob: payPerHourJob,
      payPerTaskJob: payPerTaskJob,
      pinDate: pinDate,
      postTypeId: postTypeId,
      usedPoint: usedPoint,
    );
  }

  getFeeConfig() async {
    final result = await _feeDataService.getFeeConfig();
    if (result != null) {
      _feeConfig.value = result;
      update();
    }
  }

  getWorkType() async {
    final GetWorkTypeRequest data = GetWorkTypeRequest(
      page: '1',
      pageSize: '100',
    );

    final response = await _workTypeRepository.getList(data);
    if (response != null) {
      workTypes.addAll(response.workTypes);
    }
  }

  getGardens() async {
    final int accountId = AuthCredentials.instance.user!.id!;

    GetGardenRequest data = GetGardenRequest(
      accountId: accountId.toString(),
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
      final List<TreeType> responseTreeTypes = response.treeTypes!;
      treeTypes = responseTreeTypes.obs;
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
      final List<PostType> responsePostTypes = response.postTypes!;
      postTypes = responsePostTypes.obs;
      update();
    }
  }

  // bool isUpgradeDateAvailable() {
  //   if (publishDateController.text.isEmpty || selectedPostType.value == null) {
  //     return false;
  //   }
  //
  //   return true;
  // }

  // void isNumOfUpgradeDateAvailable() {
  //   if (isUpgradeDateAvailable() && upgradeDateController.text.isNotEmpty) {
  //     isEnableDayEdit.value = true;
  //   } else {
  //     isEnableDayEdit.value = false;
  //   }
  // }

  // resetUpgradeData() {
  //   selectedPostType = Rx(null);
  //   upgradeDateController.text = '';
  //   numOfUpgradeDay.value = 0;
  // }

  // getAvailablePinDates() async {
  //   if (!isUpgradeDateAvailable() || !isUpgrade.value) return;
  //
  //   //clear current list
  //   availablePinDates.clear();
  //
  //   final data = CheckPinDateRequest(
  //     publishedDate: Utils.fromddMMyyyy(publishDateController.text),
  //     // numOfPublishDay: numOfPublishDay.value.toString(),
  //     postTypeId: selectedPostType.value!.id.toString(),
  //   );
  //
  //   List<DateTime>? pinDates =
  //       await _jobPostRepository.getAvailablePinDates(data);
  //   if (pinDates != null) {
  //     availablePinDates.addAll(pinDates);
  //   }
  // }

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

  void onWorkTypeChange(WorkType? workType) {
    selectedWorkType.value = workType;
    print(selectedWorkType.value?.name);
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

  //functions for work pay type dropdown list
  bool compareWorkPayType(String? s1, String? s2) {
    if (s1 != null && s2 != null) {
      return Utils.equalsUtf8String(s1, s2);
    }
    return false;
  }

  void onWorkPayTypeChange(String? s) {
    if (s != null) {
      selectedWorkPayType.value = s;
    }
  }

  //functions for post type dropdown list
  bool comparePostType(PostType? t1, PostType? t2) {
    if (t1 != null && t2 != null) {
      return t1.id == t2.id;
    }
    return false;
  }

  //functions for garden dropdown list
  bool compareWorkType(WorkType? o1, WorkType? o2) {
    if (o1 != null && o2 != null) {
      return o1.id == o2.id;
    }
    return false;
  }

  void onPostTypeChange(PostType? postType) {
    selectedPostType.value = postType;
    postTypeCost.value = postType == null ? 0.0 : postType.price;
    calUpgradeCost();
    // getAvailablePinDates();
    // getMaxPinDay();
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
    DateTime now = DateUtils.dateOnly(DateTime.now());
    DateTime firstDate = jobStartDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(jobStartDateController.text)
        : now;
    DateTime? initDate = jobEndDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(jobEndDateController.text)
        : firstDate;
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
    // if (availablePinDates.isEmpty) {
    //   InformationDialog.showDialog(
    //     msg:
    //         'Không có ngày pin phù hợp cho gói nâng cấp này vào những ngày bạn chọn',
    //     confirmTitle: AppStrings.titleClose,
    //   );
    //   return;
    // }

    // DateTime firstDate = availablePinDates[0];
    // DateTime initDate = upgradeDateController.text.isNotEmpty
    //     ? Utils.fromddMMyyyy(upgradeDateController.text)
    //     : firstDate;
    // DateTime lastDate = availablePinDates[availablePinDates.length - 1];

    // DateTime? pickedDate = await MyDatePicker.show(
    //   firstDate: firstDate,
    //   initDate: initDate,
    //   lastDate: lastDate,
    //   selectableDayPredicate: (date) => availablePinDates.contains(date),
    // );

    // if (pickedDate != null) {
    //   upgradeDateController.text = Utils.formatddMMyyyy(pickedDate);
    //   isNumOfUpgradeDateAvailable();
    //   await getMaxPinDay();
    // }

    DateTime firstDate = publishDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(publishDateController.text)
        : DateTime.now();
    DateTime lastDate = jobEndDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(jobEndDateController.text)
        : DateTime.now().add(const Duration(days: 60));

    DateTimeRange? upgradedRange = await MyDateRangePicker.show(
      firstDate: firstDate,
      lastDate: lastDate,
      initDateRange: selectedUpgradedRange,
    );

    if (upgradedRange != null) {
      print(upgradedRange.start.toIso8601String());
      print(upgradedRange.end.toIso8601String());
      selectedUpgradedRange = upgradedRange;
      numOfUpgradeDay.value =
          upgradedRange.end.difference(upgradedRange.start).inDays + 1;
      calUpgradeCost();

      if (upgradedRange.start.isAtSameMomentAs(upgradedRange.end)) {
        upgradeDateController.text = Utils.formatddMMyyyy(upgradedRange.start);
      } else {
        upgradeDateController.text =
            '${Utils.formatddMMyyyy(upgradedRange.start)} - ${Utils.formatddMMyyyy(upgradedRange.end)}';
      }
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
      clearPinDate();
    }
  }

  void clearPinDate() {
    if (isUpgrade.value) {
      selectedUpgradedRange = null;
      upgradeDateController.text = '';
      numOfUpgradeDay.value = 0;
    }
  }

  // calPostingFee() {
  //   totalPostingMoney.value =
  //       _feeConfig.value.postingFeePerDay * numOfPublishDay.value;
  // }

  //handle onChange number of publish day
  // void onChangeNumOfPublishDay(double value) {
  //   numOfPublishDay.value = value.toInt();
  //
  //   calPostingFee();
  //   calTotalFee();
  //   getAvailablePinDates();
  // }

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

  // void onChangeNumOfUpgradeDay(double value) {
  //   numOfUpgradeDay.value = value.toInt();
  //   calUpgradeCost();
  // }

  // getMaxPinDay() async {
  //   if (upgradeDateController.text.isEmpty) return;
  //   final data = GetMaxPinDayRequest(
  //     pinDate: Utils.fromddMMyyyy(upgradeDateController.text),
  //     // numOfPublishDay: numOfPublishDay.value.toString(),
  //     postTypeId: selectedPostType.value!.id.toString(),
  //   );
  //   maxDay.value = await _jobPostRepository.getMaxPinDay(data);
  // }

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

  String? validateWorkTypeSelection(WorkType? workType) {
    if (workType == null) return AppMsg.MSG0002;
    return null;
  }

  String? validateWorkPayType(String? value) {
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

    if (selectedWorkPayType.value == AppStrings.payPerTask &&
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

  // String? validateNumOfUpgradeDay(String? value) {
  //   if (!Utils.isPositiveInteger(value!)) {
  //     return AppMsg.MSG0010;
  //   }
  //
  //   //check upgrade date
  //   if (upgradeDateController.text.isNotEmpty &&
  //       publishDateController.text.isNotEmpty &&
  //       isUpgrade.value) {
  //     DateTime endUpradeDate = Utils.fromddMMyyyy(upgradeDateController.text)
  //         .add(Duration(days: int.parse(value)));
  //     DateTime endPublishDate = Utils.fromddMMyyyy(publishDateController.text)
  //         .add(Duration(days: numOfPublishDay.value));
  //     Duration difference = endPublishDate.difference(endUpradeDate);
  //     if (difference.inDays < 0) {
  //       return 'Ngày nâng cấp không hợp lệ';
  //     }
  //   }
  //   return null;
  // }

  String? validatePublishDate(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    DateTime publishDate = Utils.fromddMMyyyy(value!);

    // publish date must be before start date
    if (jobStartDateController.text.isNotEmpty) {
      DateTime startDate = Utils.fromddMMyyyy(jobStartDateController.text);

      if (startDate.compareTo(publishDate) <= 0) {
        return 'Ngày đăng bài phải trước ngày bắt đầu công việc';
      }
    }

    return null;
  }

  // String? validateNumOfPublishDay(String? value) {
  //   if (Utils.isEmpty(value)) {
  //     return AppMsg.MSG0002;
  //   }
  //
  //   if (!Utils.isPositiveInteger(value!)) {
  //     return AppMsg.MSG0010;
  //   }
  //
  //   // if (int.parse(value) < 3) {
  //   //   return AppMsg.MSG4004;
  //   // }
  //
  //   return null;
  // }
}
