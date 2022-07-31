import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/tree_type/tree_type_models.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class TreeTypeRepository {
  final _apiProvider = Get.find<ApiProvider>();

  Future<GetTreeTypeResponse?> getList(GetTreeTypeRequest data) async {
    final response =
        await _apiProvider.getMethod('/treetype', data: data.toJson());
    if (response.statusCode == HttpStatus.ok) {
      return GetTreeTypeResponse.fromJson(response.body);
    }
    return null;
  }
}
