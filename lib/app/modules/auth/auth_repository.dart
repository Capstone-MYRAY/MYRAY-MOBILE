import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/request/auth_request.dart';
import 'package:myray_mobile/app/data/models/request/signup_request.dart';
import 'package:myray_mobile/app/data/models/response/auth_response.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class AuthRepository {
  final ApiProvider _apiProvider = Get.find();

  AuthRepository();

  Future<bool> signup(SignupRequest data) async {
    final response = await _apiProvider.postMethod(
        path: '/Authentication/signup', data: data);
    if (response.isOk) return true;
    return false;
  }

  Future<AuthResponse?> login(AuthRequest data) async {
    final response = await _apiProvider.postMethod(
        path: '/Authentication/login', data: data);
    print(response.body.toString());
    if (response.isOk) return AuthResponse.fromJson(response.body);
    if (response.hasError) {
      throw CustomException(response.body.toString());
    }
    return null;
  }

  Future<bool> checkDuplicatedPhone(String phoneNum) async {
    final response =
        await _apiProvider.getMethod(path: '/Account/phone/$phoneNum');
    if (response.statusCode == 200) return true;
    return false;
  }
}
