import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/auth/job_post_response.dart';
import 'package:myray_mobile/app/data/models/job_post/get_request_job_post_list.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class JobPostRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<JobPostResponse?> getJobPostList(GetRequestJobPostList data) async {
    final response = await _apiProvider.getMethod('/jobpost', data: data.toJson());
    if(response.statusCode == HttpStatus.ok){
      return JobPostResponse.fromJson(response.body);
    }
    if(response.statusCode == HttpStatus.badRequest){
      throw CustomException('Job post repo: Đường dẫn có vấn đề nha');
    }

    if(response.statusCode == HttpStatus.internalServerError){
      throw CustomException('Job post repo: Service đang bảo trì hoặc sập cmnr, liên lạc với Lâm');
    }
    return null;
  }
}