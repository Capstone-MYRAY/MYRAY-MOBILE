
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

import '../../../data/models/response/job_post_response.dart';

class FarmerJobPostRepository{

  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  Future<JobPostResponse?> getJobPostList(int page, int pageSize) async {
    final response = await _apiProvider.getMethod('/JobPost?Status=2&page=$page&page-size=$pageSize');
    print("djgfhdfj");
    if(response.statusCode == HttpStatus.ok){
      return JobPostResponse.fromJson(response.body);
    }
    return null;
  }
}