import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/area/get_area_request.dart';
import 'package:myray_mobile/app/data/models/area/get_area_response.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class AreaRepository {
  final _apiProvider = Get.find<ApiProvider>();

  Future<GetAreaResponse?> getAreas(GetAreaRequest data) async {
    final response = await _apiProvider.getMethod('/Area', data: data.toJson());
    final int? statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      return GetAreaResponse.fromJson(response.body);
    }

    if (statusCode == HttpStatus.noContent) {
      throw CustomException('No area');
    }

    return null;
  }
}
