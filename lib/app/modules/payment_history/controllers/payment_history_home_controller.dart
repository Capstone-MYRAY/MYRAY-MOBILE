import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history_models.dart';
import 'package:myray_mobile/app/modules/payment_history/payment_history_repository.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/controls/my_date_range_picker.dart';

class PaymentHistoryHomeController extends GetxController {
  final _paymentHistoryRepository = Get.find<PaymentHistoryRepository>();
  RxList<PaymentHistory> paymentHistories = RxList();
  int _currentPage = 0;
  final int _pageSize = 10;
  bool _hasNextPage = true;

  final isLoading = false.obs;

  late TextEditingController messageController;

  bool isClearFilter = false;

  DateTimeRange? rangeDate;
  int? statusFilter;
  String messageFilter = '';

  @override
  void onInit() {
    super.onInit();
    messageController = TextEditingController();
  }

  onClearFilter() {
    statusFilter = null;
    rangeDate = null;
  }

  onApplyFilter() {
    onRefresh();
    Get.back(); //close filter dialog
  }

  PaymentHistory? findById(int id) {
    return paymentHistories.firstWhereOrNull((payment) => payment.id == id);
  }

  Future<DateTimeRange?> onChooseIssuedDate() async {
    final now = DateTime.now();
    final firstDate = now.subtract(const Duration(days: 365));
    DateTimeRange? selectedRange = await MyDateRangePicker.show(
      firstDate: firstDate,
      lastDate: now,
      initDateRange: rangeDate,
    );

    return selectedRange;
  }

  setDateRangeText(
      DateTimeRange? selectedRange, TextEditingController textController) {
    if (selectedRange == null) {
      textController.text = '';
      return;
    }

    if (selectedRange.start.isAtSameMomentAs(selectedRange.end)) {
      textController.text = Utils.formatddMMyyyy(selectedRange.start);
    } else {
      textController.text =
          '${Utils.formatddMMyyyy(selectedRange.start)} - ${Utils.formatddMMyyyy(selectedRange.end)}';
    }
  }

  Future<bool?> getPaymentHistories() async {
    final int accountId = AuthCredentials.instance.user!.id!;
    final data = GetPaymentHistoryRequest(
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      sortColumn: PaymentHistorySortColumn.createdDate,
      orderBy: SortOrder.descending,
      status: statusFilter?.toString(),
      fromDate: rangeDate?.start,
      toDate: rangeDate?.end,
      message: messageFilter,
    );

    //load job post
    isLoading.value = true;

    if (_hasNextPage) {
      final response = await _paymentHistoryRepository.getList(accountId, data);
      if (response == null || response.paymentHistories!.isEmpty) {
        isLoading.value = false;
        return null;
      }

      paymentHistories.addAll(response.paymentHistories!);
      //update hasNext
      _hasNextPage = response.metadata!.hasNextPage;
    }
    isLoading.value = false;
    return true;
  }

  Future<void> onRefresh() async {
    //reset current page & hasNext
    _currentPage = 0;
    _hasNextPage = true;

    //clear job post list
    paymentHistories.clear();

    update();
  }
}
