import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/upload_file/upload_image_response.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class UploadImageService {
  final _apiProvider = Get.find<ApiProvider>();

  Future<UploadImageResponse?> uploadImage(List<MultipartFile> images) async {
    final formData = FormData({'formFiles': images});
    final response = await _apiProvider.multipartFile('/File', formData);
    print('Upload: ${response.body}');
    if (response.statusCode == HttpStatus.ok) {
      return UploadImageResponse.fromJson(response.body);
    }
    return null;
  }

  Future<bool> deleteImages(List<String> images) async {
    final response = await _apiProvider.deleteImage('/File/delete', images);
    print('Delete: ${response.statusCode}');
    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
    return false;
  }
}
