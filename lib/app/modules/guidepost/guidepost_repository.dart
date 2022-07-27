
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/guidepost/get_guidepost_request.dart';
import 'package:myray_mobile/app/data/models/guidepost/get_guidepost_response.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class GuidepostRepository{
  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final _url = '/guidepost';

  Future<GetGuidepostResponse?> getGuideposts (GetGuidepostRequest data) async {
    final response = await _apiProvider.getMethod(_url, data: data.toJson());
    if(response.statusCode == HttpStatus.ok){
      return GetGuidepostResponse.fromJson(response.body);
    }
    return null;
  }
}