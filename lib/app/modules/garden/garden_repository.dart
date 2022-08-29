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
  final path = '/garden';

  Future<Garden?> create(PostGardenRequest data) async {
    final response = await _apiProvider.postMethod(path, data.toJson());
    if (response.isOk) {
      return Garden.fromJson(response.body);
    }
    return null;
  }

  Future<Garden?> update(Garden data) async {
    final response = await _apiProvider.putMethod(path, data.toJson());
    if (response.isOk) {
      return Garden.fromJson(response.body);
    }
    return null;
  }

  Future<GetGardenResponse?> getGardens(GetGardenRequest data) async {
    final response = await _apiProvider.getMethod(path, data: data.toJson());

    print(response.statusCode);
    if (response.statusCode == null) {
      throw CustomException('No response');
    }

    if (response.statusCode == HttpStatus.ok) {
      return GetGardenResponse.fromJson(response.body);
    }

    if (response.statusCode == HttpStatus.noContent) {
      throw CustomException('No content');
    }

    return null;
  }

  Future<Garden?> getById(int id) async {
    final response = await _apiProvider.getMethod('$path/$id');
    if (response.statusCode == null) {
      throw CustomException('No response');
    }

    if (response.statusCode == HttpStatus.ok) {
      return Garden.fromJson(response.body);
    }

    if (response.statusCode == HttpStatus.noContent) {
      throw CustomException('No content');
    }

    return null;
  }

  Future<bool> canDelete(int gardenId) async {
    final response =
        await _apiProvider.getMethod('$path/noavailable/$gardenId');

    return response.body;
  }

  Future<bool> delete(int gardenId) async {
    final response = await _apiProvider.deleteMethod('$path/$gardenId');

    if (response.isOk) {
      return true;
    }

    return false;
  }
}
