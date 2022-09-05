import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/auth/auth_request.dart';
import 'package:myray_mobile/app/data/models/auth/auth_response.dart';
import 'package:myray_mobile/app/data/models/auth/signup_request.dart';
import 'package:myray_mobile/app/data/models/change_password/change_password.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class AuthRepository {
  final ApiProvider _apiProvider = Get.find();

  AuthRepository();

  Future<bool> signup(SignupRequest data) async {
    final response =
        await _apiProvider.postMethod('/Authentication/signup', data.toJson());
    if (response.isOk) return true;
    return false;
  }

  Future<AuthResponse?> login(AuthRequest data) async {
    final response =
        await _apiProvider.postMethod('/Authentication/login', data.toJson());
    if (response.isOk) return AuthResponse.fromJson(response.body);

    if (response.hasError) {
      throw CustomException(response.body.toString());
    }
    return null;
  }

  Future<bool> checkDuplicatedPhone(String phoneNum) async {
    final response = await _apiProvider.getMethod('/Account/phone/$phoneNum');
    if (response.statusCode == 200) return true;
    return false;
  }

  Future<Account?> changePassword(ChangePassword data) async {
    final response = await _apiProvider.postMethod(
        '/Authentication/changepassword', data.toJson());
    if (response.statusCode == HttpStatus.ok) {
      return Account.fromJson(response.body);
    }
    return null;
  }

  Future<bool> checkOldPassword(String oldPassword) async {
    final response =
        await _apiProvider.post('/authentication/checkpassword', oldPassword);
    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    }
    return false;
  }

  Future<bool> resetPassword(String phoneNumber) async {
    final response = await _apiProvider.post(
        '/authentication/resetpassword', json.encode(phoneNumber));

    print(response.bodyString);

    if (response.isOk) {
      return true;
    }

    return false;
  }
}
