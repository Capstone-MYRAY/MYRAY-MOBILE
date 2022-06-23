import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:myray_mobile/app/data/environment.dart';
import 'package:myray_mobile/app/data/models/auth/auth_response.dart';
import 'package:myray_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:myray_mobile/app/shared/constants/app_msg.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/widgets/information_dialog.dart';

class BaseProvider extends GetConnect {
  final _authController = Get.find<AuthController>();

  @override
  void onInit() {
    httpClient.baseUrl = Environment.apiUrl;
    httpClient.defaultContentType = 'application/json; charset=utf-8';

    httpClient.addRequestModifier(requestInterceptor);

    httpClient.addAuthenticator<dynamic>((request) async {
      //unauthorized
      String token = AuthCredentials.instance.getToken() ?? '';
      String refreshToken = AuthCredentials.instance.getRefreshToken() ?? '';

      final data = AuthResponse(token: token, refreshToken: refreshToken);

      try {
        AuthResponse? tokens = await this.refreshToken(data);
        if (tokens == null) {
          return request;
        }

        _authController.login(tokens.token!, tokens.refreshToken!);
        print('create auth header');
        Map<String, String> headers = {'Authorization': 'Bearer $token'};
        request.headers.addAll(headers);
      } on CustomException catch (e) {
        _authController.logOut();
        bool? isDialogOpen = Get.isDialogOpen;
        if (isDialogOpen == null) {
          InformationDialog.showDialog(
            msg: e.message,
            confirmTitle: 'Đóng',
          );
        }
      }

      return request;
    });

    httpClient.addResponseModifier((request, response) async {
      print('status: ${response.statusCode}');

      return response;
    });
  }

  Future<AuthResponse?> refreshToken(AuthResponse data) async {
    final response = await post('/Authentication/refresh', data.toJson());
    if (response.isOk) return AuthResponse.fromJson(response.body);
    throw CustomException(AppMsg.MSG0009);
  }

  FutureOr<Request> requestInterceptor(request) async {
    String token = AuthCredentials.instance.getToken() ?? '';

    if (token.isNotEmpty) {
      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      request.headers.addAll(headers);
    }

    return request;
  }
}
