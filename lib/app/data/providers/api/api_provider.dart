import 'package:get/get.dart';
import 'package:myray_mobile/app/data/providers/api/base_provider.dart';

class ApiProvider extends BaseProvider {
  Future<Response> getMethod(String path, {Map<String, dynamic>? data}) {
    return get(path, query: data);
  }

  Future<Response> postMethod(String path, Map<String, dynamic> data) {
    return post(path, data);
  }

  Future<Response> putMethod(String path, Map<String, dynamic> data) {
    return put(path, data);
  }

  Future<Response> deleteMethod(String path) {
    return delete(path);
  }

  Future<Response> deleteImage(String path, dynamic data) {
    return post(path, data);
  }

  Future<Response> patchMethod(String path, {Map<String, dynamic>? data}) {
    return patch(path, data);
  }

  Future<Response> multipartFile(String path, dynamic body) {
    return post(path, body, contentType: "multipart/form-data");
  }
}
