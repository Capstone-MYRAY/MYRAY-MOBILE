import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/post_type/post_type_models.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class PostTypeRepository {
  final _apiProvider = Get.find<ApiProvider>();

  Future<GetPostTypeResponse?> getList(GetPostTypeRequest data) async {
    final response =
        await _apiProvider.getMethod('/posttype', data: data.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return GetPostTypeResponse.fromJson(response.body);
    }

    return null;
  }
}
