import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/upload_file/upload_image_response.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class UploadImageService {
  final _apiProvider = Get.find<ApiProvider>();

  Future<UploadImageResponse?> uploadImage(FormData images) async {
    final response = await _apiProvider.multipartFile('/File', images);
    if (response.statusCode == HttpStatus.ok) {
      return UploadImageResponse.fromJson(response.body);
    }
    return null;
  }
}
