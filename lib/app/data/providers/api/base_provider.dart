import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/response/auth_response.dart';
import 'package:myray_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:myray_mobile/app/shared/constants/app_msg.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/widgets/information_dialog.dart';

import 'api_constants.dart';

class BaseProvider extends GetConnect {
  final _authController = Get.find<AuthController>();

  Future<AuthResponse?> refreshToken(AuthResponse data) async {
    final response = await post(
        '${ApiConstants.baseUrl}/Authentication/refresh', data.toJson());
    if (response.isOk) return AuthResponse.fromJson(response.body);
    throw CustomException(AppMsg.MSG0009);
  }

  @override
  void onInit() {
    httpClient.baseUrl = ApiConstants.baseUrl;
    httpClient.defaultContentType = ApiConstants.contentType;

    httpClient.addAuthenticator<dynamic>((request) async {
      String token = AuthCredentials.instance.getToken() ?? '';

      if (token.isNotEmpty) {
        print('create header');
        Map<String, String> headers = {'Authorization': 'Bearer $token'};
        request.headers.addAll(headers);
      }

      return request;
    });

    httpClient.addResponseModifier((request, response) async {
      String token = AuthCredentials.instance.getToken() ?? '';
      if (response.status.isUnauthorized && token.isNotEmpty) {
        print('status: ${response.statusCode}');
        String refreshToken = AuthCredentials.instance.getRefreshToken() ?? '';
        print('refresh token');
        final data = AuthResponse(token: token, refreshToken: refreshToken);
        try {
          AuthResponse? tokens = await this.refreshToken(data);
          if (tokens == null) {
            return response;
          }

          _authController.login(tokens.token!, tokens.refreshToken!);
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
      }
      return response;
    });
  }
}
