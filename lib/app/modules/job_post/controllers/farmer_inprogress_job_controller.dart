import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/controls/my_date_picker.dart';

class FarmerInprogressJobController extends GetxController {
  late GlobalKey<FormState> formKey;

  late TextEditingController reportContentController;

  late TextEditingController onLeaveStartDateController;
  late TextEditingController onLeaveEndDateController;
  late TextEditingController onLeaveReasonController;

  late TextEditingController extendJobDateController;
  late TextEditingController extendJobReasonController;

  @override
  void onInit() async {
    formKey = GlobalKey<FormState>();

    reportContentController = TextEditingController();

    onLeaveStartDateController = TextEditingController();
    onLeaveReasonController = TextEditingController();
    onLeaveEndDateController = TextEditingController();

    extendJobDateController = TextEditingController();
    extendJobReasonController = TextEditingController();
    super.onInit();
  }

  String? validateReason(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng nhập lý do';
    }
    return null;
  }

  String? validateChooseOnleaveEndDate(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng chọn ngày kết thúc nghỉ';
    }
    return null;
  }

  String? validateChooseOnleaveStartDate(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng chọn ngày bắt đầu nghỉ';
    }
    if (onLeaveEndDateController.text.isNotEmpty) {
      DateTime startDate = Utils.fromddMMyyyy(onLeaveStartDateController.text);
      DateTime endDate = Utils.fromddMMyyyy(onLeaveEndDateController.text);
      if (startDate.isAfter(endDate)) {
        return 'Ngày bắt đầu nghỉ phải trước ngày kết thúc nghỉ';
      }
    }
    return null;
  }

  String? validateChooseNewEndDate(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng chọn ngày kết thúc mới';
    }
    //Valid just only extend end job date once
    
    return null;
  }

  void onChooseOnLeaveStartDate() async {
    DateTime? _initDate = onLeaveStartDateController.text.isEmpty
        ? DateTime.now().add(const Duration(days: 1))
        : Utils.fromddMMyyyy(onLeaveStartDateController.text);
    DateTime? _pickedDate = await MyDatePicker.show(
        initDate: _initDate,
        firstDate: _initDate,
        lastDate: DateTime.now()
            .add(const Duration(days: 365 * 10))); //check ngày end job
    if (_pickedDate != null) {
      onLeaveStartDateController.text = Utils.formatddMMyyyy(_pickedDate);
    }
    if (onLeaveEndDateController.text.isEmpty) {
      onLeaveEndDateController.text = onLeaveStartDateController.text;
    }
  }

  void onChooseOnLeaveEndDate() async {
    DateTime now = DateTime.now();
    DateTime _firstDate = onLeaveStartDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(onLeaveStartDateController.text)
        : now;
    DateTime? _initDate = !_firstDate.isAtSameMomentAs(now)
        ? _firstDate
        : onLeaveEndDateController.text.isNotEmpty
            ? Utils.fromddMMyyyy(onLeaveEndDateController.text)
            : null;

    DateTime? _pickedDate = await MyDatePicker.show(
        firstDate: _firstDate,
        initDate: _initDate,
        lastDate: _firstDate.add(
            const Duration(days: 29))); // not include the first day; max = 30
    print('_pickedDate: $_pickedDate');

    if (_pickedDate != null) {
      onLeaveEndDateController.text = Utils.formatddMMyyyy(_pickedDate);
    }
  }

  void onChooseNewEndDate(DateTime oldDate) async {
    // DateTime now = DateTime.now();
    DateTime _firstDate = onLeaveStartDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(onLeaveStartDateController.text)
        : oldDate.add(const Duration(days: 1));
    DateTime? _pickedDate = await MyDatePicker.show(
        firstDate: _firstDate,
        initDate: oldDate.add(const Duration(days: 1)),
        lastDate: _firstDate.add(
            const Duration(days: 6))); // not include the first day; max = 7
    print('_pickedDate: $_pickedDate');

    if (_pickedDate != null) {
      extendJobDateController.text = Utils.formatddMMyyyy(_pickedDate);
    }
  }

  onCloseReportDialog() {
    reportContentController.clear();
    Get.back();
  }

  onCloseOnLeaveDialog() {
    onLeaveStartDateController.clear();
    onLeaveEndDateController.clear();
    onLeaveReasonController.clear();
    Get.back();
  }

  onCloseExtendJobDialog() {
    extendJobDateController.clear();
    extendJobReasonController.clear();
    Get.back();
  }

  onSubmitReportForm() {
    bool isFormValid = formKey.currentState!.validate();
    print(isFormValid ? reportContentController.value : 'no valid');
    if (isFormValid) {
      // do some code here
      onCloseReportDialog();
    }
  }

  onSubmitOnleaveForm() {
    bool isFormValid = formKey.currentState!.validate();
    print(isFormValid);
    print(onLeaveEndDateController.text);

    if (isFormValid) {
      //do some code here
      onCloseOnLeaveDialog();
    }
  }

  onSubmitExtendJobForm() {
    bool isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      //do some code here
      onCloseExtendJobDialog();
    }
  }
}
