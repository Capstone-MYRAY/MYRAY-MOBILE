import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class ProfileRepository {
  final _apiProvider = Get.find<ApiProvider>();

  Future<Account?> getUser(int id) async {
    final response = await _apiProvider.getMethod('/Account/$id');
    if (response.statusCode == HttpStatus.ok) {
      return Account.fromJson(response.body);
    }

    return null;
  }
}
