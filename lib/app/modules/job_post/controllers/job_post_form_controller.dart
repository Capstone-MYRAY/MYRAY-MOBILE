import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/fee_data.dart';
import 'package:myray_mobile/app/data/models/garden/garden_models.dart';
import 'package:myray_mobile/app/data/models/tree_type/tree_type_models.dart';
import 'package:myray_mobile/app/data/services/tree_type_repository.dart';
import 'package:myray_mobile/app/modules/garden/garden_repository.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class JobPostFormController extends GetxController {
  //TODO: [postingFee] and [pointCost] will be fetched from server
  final double postingFee = FeeData.postPerDay;
  final double pointCost = FeeData.pointPayFor1VND;
  final double postTypeCost = 10000; //test only

  final _gardenRepository = Get.find<GardenRepository>();
  final _treeTypeRepository = Get.find<TreeTypeRepository>();

  final RxList<Garden> gardens = RxList<Garden>();
  Rx<Garden?> selectedGarden = Rx(null);

  RxList<TreeType>? treeTypes;
  RxList<int> selectedTreeTypes = RxList<int>();

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
  late TextEditingController hourSalaryController;
  late TextEditingController startHourController;
  late TextEditingController endHourController;

  //controllers for pay per task job
  late TextEditingController taskSalaryController;
  late TextEditingController jobEndDate;

  //controllers for upgrade job
  late TextEditingController upgradeDateController;
  late TextEditingController numOfUpgradeDateController;

  String get numOfPublishDayEquation =>
      '${Utils.vietnameseCurrencyFormat.format(postingFee)} x ${numOfPublishDay.value} (ngày)';
  String get publishFee =>
      '= ${Utils.vietnameseCurrencyFormat.format(totalPostingMoney.value)}';

  String get usingPointEquation =>
      '${Utils.vietnameseCurrencyFormat.format(pointCost)} x ${usingPoint.value} (điểm)';
  String get totalReduce =>
      '= ${Utils.vietnameseCurrencyFormat.format(totalDiscountByPoint.value)}';

  String get upgradeEquation =>
      '${Utils.vietnameseCurrencyFormat.format(postTypeCost)} x ${numOfUpgradeDay.value} (ngày)';
  String get totalUpgrade =>
      '= ${Utils.vietnameseCurrencyFormat.format(upgradeCost.value)}';

  @override
  void onInit() async {
    formKey = GlobalKey<FormState>();

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
    hourSalaryController = TextEditingController();
    startHourController = TextEditingController();
    endHourController = TextEditingController();

    //create controller for pay per task job
    taskSalaryController = TextEditingController();
    jobEndDate = TextEditingController();

    //create controller for upgrade job post
    upgradeDateController = TextEditingController();
    numOfUpgradeDateController = TextEditingController();

    //get garden list
    await getGardens();

    //get tree type list
    await getTreeTypes();

    super.onInit();
  }

  getGardens() async {
    final int _accountId = AuthCredentials.instance.user!.id!;

    GetGardenRequest data = GetGardenRequest(
      accountId: _accountId.toString(),
      page: 1.toString(),
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
    GetTreeTypeRequest data =
        GetTreeTypeRequest(page: 1.toString(), pageSize: 100.toString());

    final GetTreeTypeResponse? _response =
        await _treeTypeRepository.getList(data);

    if (_response != null && _response.treeTypes != null) {
      final List<TreeType> _treeTypes = _response.treeTypes!;
      treeTypes = _treeTypes.obs;
      update();
      print(treeTypes!.map((type) => type.toJson()).toList().toString());
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

  //open time picker
  Future<TimeOfDay?> chooseTime() {
    return showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      confirmText: 'Chọn'.toUpperCase(),
      cancelText: 'Đóng'.toUpperCase(),
      hourLabelText: 'Giờ',
      minuteLabelText: 'Phút',
    );
  }

  //choose start hour
  void onChooseStartHour() async {
    TimeOfDay? _pickedTime = await chooseTime();
    if (_pickedTime != null) {
      String timeFormat = Utils.formatHHmm(_pickedTime);
      startHourController.text = timeFormat;
    }
  }

  //choose start hour
  void onChooseEndHour() async {
    TimeOfDay? _pickedTime = await chooseTime();
    if (_pickedTime != null) {
      String timeFormat = Utils.formatHHmm(_pickedTime);
      endHourController.text = timeFormat;
    }
  }

  //handle onChange number of publish day
  void onChangeNumOfPublishDay(String value) {
    if (value.isEmpty) {
      numOfPublishDay.value = 0;
    } else {
      numOfPublishDay.value = int.parse(value);
    }
    totalPostingMoney.value = postingFee * numOfPublishDay.value;
  }

  void onChangeUsingPoint(String value) {
    if (value.isEmpty) {
      usingPoint.value = 0;
    } else {
      usingPoint.value = int.parse(value);
    }
    totalDiscountByPoint.value = pointCost * usingPoint.value;
  }

  void onChangeNumOfUpgradeDay(String value) {
    if (value.isEmpty) {
      numOfUpgradeDay.value = 0;
    } else {
      numOfUpgradeDay.value = int.parse(value);
    }
    upgradeCost.value = postTypeCost * numOfUpgradeDay.value;
  }
}
