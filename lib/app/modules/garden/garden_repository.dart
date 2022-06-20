import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/data/models/garden/get_garden_request.dart';
import 'package:myray_mobile/app/data/models/garden/get_garden_response.dart';
import 'package:myray_mobile/app/data/models/garden/post_garden_request.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class GardenRepository {
  final _apiProvider = Get.find<ApiProvider>();

  Future<Garden?> create(PostGardenRequest data) async {
    final response = await _apiProvider.postMethod('/Garden', data.toJson());
    if (response.isOk) {
      return Garden.fromJson(response.body);
    }
    return null;
  }

  Future<GetGardenResponse?> getGardens(GetGardenRequest data) async {
    final response =
        await _apiProvider.getMethod('/Garden', data: data.toJson());
    if (response.statusCode == HttpStatus.ok) {
      return GetGardenResponse.fromJson(response.body);
    }

    if (response.statusCode == HttpStatus.ok) {
      throw CustomException('No content');
    }

    return null;
  }
}
