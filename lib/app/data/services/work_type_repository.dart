import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/work_type/get_work_type_request.dart';
import 'package:myray_mobile/app/data/models/work_type/get_work_type_response.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class WorkTypeRepository {
  final _apiRepository = Get.find<ApiProvider>();

  Future<GetWorkTypeResponse?> getList(GetWorkTypeRequest data) async {
    final response =
        await _apiRepository.getMethod('/worktype', data: data.toJson());
    if (response.statusCode == HttpStatus.ok) {
      return GetWorkTypeResponse.fromJson(response.body);
    }

    return null;
  }
}
