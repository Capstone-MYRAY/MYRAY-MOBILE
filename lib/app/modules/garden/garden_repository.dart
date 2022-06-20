import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/data/models/garden/post_garden_request.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class GardenRepository {
  final _apiProvider = Get.find<ApiProvider>();

  Future<Garden?> create(PostGardenRequest data) async {
    final response = await _apiProvider.postMethod('/Garden', data.toJson());
    if (response.isOk) {
      return Garden.fromJson(response.body);
    }
    return null;
  }
}
