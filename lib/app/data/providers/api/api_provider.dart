import 'package:get/get.dart';
import 'package:myray_mobile/app/data/providers/api/base_provider.dart';

class ApiProvider extends BaseProvider {
  Future<Response> getMethod(String path, {Map<String, dynamic>? data}) {
    return get(path, query: data);
  }

  Future<Response> postMethod(String path, Map<String, dynamic> data) {
    return post(path, data);
  }
}
