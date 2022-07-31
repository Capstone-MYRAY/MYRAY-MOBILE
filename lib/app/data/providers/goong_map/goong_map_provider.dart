import 'package:get/get.dart';
import 'package:myray_mobile/app/data/environment.dart';
import 'package:myray_mobile/app/data/providers/goong_map/goong_map_base_provider.dart';

class GoongMapProvider extends GoongMapBaseProvider {
  Future<Response> getMethod(String path, {Map<String, dynamic>? query}) {
    //add api key
    query?.addAll({'api_key': Environment.goongMapApiKey});
    return get(path, query: query);
  }
}
