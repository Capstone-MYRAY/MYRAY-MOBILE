import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/fee_data.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class FeeDataService {
  final _apiProvider = Get.find<ApiProvider>();
  Future<FeeData?> getFeeConfig() async {
    final response = await _apiProvider.getMethod('/config');
    if (response.statusCode == HttpStatus.ok) {
      return FeeData.fromJson(response.body);
    }

    return null;
  }
}
