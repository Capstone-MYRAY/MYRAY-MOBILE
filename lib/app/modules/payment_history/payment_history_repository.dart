import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history_models.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class PaymentHistoryRepository {
  final _apiProvider = Get.find<ApiProvider>();

  Future<GetPaymentHistoryResponse?> getList(
      int userId, GetPaymentHistoryRequest data) async {
    final response = await _apiProvider.getMethod('/paymenthistory/$userId',
        data: data.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return GetPaymentHistoryResponse.fromJson(response.body);
    }

    return null;
  }

  Future<PaymentHistory?> getById(int paymentId) async {
    final response =
        await _apiProvider.getMethod('/paymenthistory/id/$paymentId');

    if (response.statusCode == HttpStatus.ok) {
      return PaymentHistory.fromJson(response.body);
    }

    return null;
  }
}
