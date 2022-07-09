import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/job_post/check_pin_date_request.dart';
import 'package:myray_mobile/app/data/models/job_post/get_max_pin_day_request.dart';
import 'package:myray_mobile/app/data/models/job_post/get_request_job_post_list.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post_cru.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post_response.dart';
import 'package:myray_mobile/app/data/models/job_post/landowner_get_job_post_response.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/data/models/job_post/farmer_job_post_detail_response.dart';

class JobPostRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final JOB_POST_URL = '/jobpost';

  //Get list of job post
  Future<JobPostResponse?> getJobPostList(GetRequestJobPostList data) async {
    final response =
        await _apiProvider.getMethod(JOB_POST_URL, data: data.toJson());
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

  //Get job post detail
  Future<FarmerJobPostDetailResponse?> getFarmerJobPostdDetail(
      int jobPostId) async {
    final response = await _apiProvider.getMethod(JOB_POST_URL + "/$jobPostId");
    print("Link:  ${response.request!.url}");
    if (response.statusCode == HttpStatus.ok) {
      return FarmerJobPostDetailResponse.fromJson(response.body);
    }
    return null;
  }

  Future<LandownerGetJobPostResponse?> getLandownerJobPostList(
      GetRequestJobPostList data) async {
    final response =
        await _apiProvider.getMethod('/jobpost', data: data.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return LandownerGetJobPostResponse.fromJson(response.body);
    }

    return null;
  }

  Future<JobPost?> create(JobPostCru data) async {
    final response = await _apiProvider.postMethod('/jobpost', data.toJson());

    if (response.isOk) {
      return JobPost.fromJson(response.body);
    }

    return null;
  }

  Future<JobPost?> getById(int jobPostId) async {
    final response = await _apiProvider.getMethod('/jobpost/$jobPostId');

    if (response.isOk) {
      return JobPost.fromJson(response.body);
    }

    return null;
  }

  Future<List<DateTime>?> getAvailablePinDates(CheckPinDateRequest data) async {
    final response = await _apiProvider.getMethod('/jobpost/checkpindate',
        data: data.toJson());

    if (response.isOk) {
      final List<dynamic> dates = response.body;
      if (dates.isEmpty) return null;
      return dates.map((date) => DateTime.parse(date).toLocal()).toList();
    }

    return null;
  }

  Future<int> getMaxPinDay(GetMaxPinDayRequest data) async {
    final response = await _apiProvider.getMethod('/jobpost/getmaxpinday',
        data: data.toJson());

    return response.body;
  }

  Future<dynamic> applyJob(int data) async {
    final response = await _apiProvider
        .patchMethod('$JOB_POST_URL/apply/$data', {'jobPostId': data});
    print(response.request!.url);
    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
    return false;
  }

  //check applied
  //applied: true, not applied: true (200)
  Future<bool?> checkFarmerAppliedOrNot(int data) async {
    final response = await _apiProvider
        .getMethod('$JOB_POST_URL/checkapplied?jobPostId=$data');
    return response.statusCode != HttpStatus.ok;
  }

  // Future<Report?> reportJob(int jobId){
  //   final response = await _apiProvider.getMethod('$JOB_POST_URL/report');
  // }
}
