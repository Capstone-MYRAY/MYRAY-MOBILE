import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history_models.dart';
import 'package:myray_mobile/app/modules/payment_history/payment_history_repository.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';

class PaymentHistoryHomeController extends GetxController {
  final _paymentHistoryRepository = Get.find<PaymentHistoryRepository>();
  RxList<PaymentHistory> paymentHistories = RxList();
  int _currentPage = 0;
  final int _pageSize = 10;
  bool _hasNextPage = true;

  final isLoading = false.obs;

  Future<bool?> getPaymentHistories() async {
    final int _accountId = AuthCredentials.instance.user!.id!;
    final _data = GetPaymentHistoryRequest(
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      // sortColumn: PaymentHistorySortColumn.usedPoint,
      // orderBy: SortOrder.descending,
    );

    //load job post
    isLoading.value = true;

    if (_hasNextPage) {
      final _response =
          await _paymentHistoryRepository.getList(_accountId, _data);
      if (_response == null || _response.paymentHistories!.isEmpty) {
        isLoading.value = false;
        return null;
      }

      paymentHistories.addAll(_response.paymentHistories!);
      //update hasNext
      _hasNextPage = _response.metadata!.hasNextPage;
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

    await getPaymentHistories();
  }
}
