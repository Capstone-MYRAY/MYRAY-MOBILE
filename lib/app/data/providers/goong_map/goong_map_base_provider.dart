import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:myray_mobile/app/data/environment.dart';

class GoongMapBaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Environment.goongMapUrl;
    httpClient.addRequestModifier(_requestInterceptor);
  }

  FutureOr<Request<dynamic>> _requestInterceptor(
      Request<dynamic> request) async {
    print(request.url.queryParameters);

    return request;
  }
}
