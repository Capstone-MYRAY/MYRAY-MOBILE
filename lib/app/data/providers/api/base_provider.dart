import 'package:get/get.dart';

import 'api_constants.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = ApiConstants.baseUrl;
    httpClient.followRedirects = false;
  }
}
