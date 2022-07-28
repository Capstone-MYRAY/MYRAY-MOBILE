import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/profile/update_profile_request.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class ProfileRepository {
  final _apiProvider = Get.find<ApiProvider>();

  Future<Account?> getUser(int id) async {
    final response = await _apiProvider.getMethod('/account/$id');
    if (response.statusCode == HttpStatus.ok) {
      return Account.fromJson(response.body);
    }

    return null;
  }

  Future<Account?> updateProfile(UpdateProfileRequest data) async {
    final response = await _apiProvider.putMethod('/account', data.toJson());

    print('Update account: ${response.bodyString}');

    if (response.statusCode == HttpStatus.ok) {
      return Account.fromJson(response.body);
    }

    return null;
  }
}
