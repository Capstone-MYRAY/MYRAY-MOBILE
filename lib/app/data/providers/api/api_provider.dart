import 'package:get/get.dart';
import 'package:myray_mobile/app/data/providers/api/base_provider.dart';

class ApiProvider extends BaseProvider {
  Future<Response> getMethod({required String path, dynamic data}) {
    return get(path);
  }

  Future<Response> postMethod({required String path, dynamic data}) {
    return post(path, data.toJson(), headers: {"Accept": "application/json"});
  }
}
