
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_request.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post_response.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class HistoryJobRepository{

  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final _url = '/jobpost';

  Future<JobPostResponse?> getHistoryJobPostList(GetAppliedJobRequest data) async {
    final response =
        await _apiProvider.getMethod(_url, data: data.toJson());
    if (response.statusCode == HttpStatus.ok) {
      return JobPostResponse.fromJson(response.body);
    }
    if (response.statusCode == HttpStatus.badRequest) {
      throw CustomException('Job post repo: Đường dẫn có vấn đề nha');
    }

    if (response.statusCode == HttpStatus.internalServerError) {
      throw CustomException(
          'Job post repo: Service đang bảo trì hoặc sập cmnr, liên lạc với Lâm');
    }
    return null;
  }


}