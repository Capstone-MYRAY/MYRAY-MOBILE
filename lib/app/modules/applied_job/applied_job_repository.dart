import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_request.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_response.dart';
import 'package:myray_mobile/app/data/models/job_post/get_request_job_post_list.dart';
import 'package:myray_mobile/app/data/models/report/post_report_request.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class AppliedJobRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final jobPostUrl = '/jobpost';

  Future<GetAppliedJobPostList?> getAppliedJobList(
      GetAppliedJobRequest data) async {
    final response = await _apiProvider.getMethod('$jobPostUrl/appliedfarmer',
        data: data.toJson());
    print("url: ${response.request!.url}");
    if (response.statusCode == HttpStatus.ok) {
      return GetAppliedJobPostList.fromJson(response.body);
    }
    return null;
  }

  Future<bool?> cancelAppliedJob(int jobPostId) async {
    final response = await _apiProvider.patchMethod(
        '$jobPostUrl/cancel/$jobPostId',
        data: {'job_post_id': jobPostId});
    print(response.request!.url);
    return response.statusCode == HttpStatus.ok;
  }

   //report job for farmer
  Future<Report?> reportJob(PostReportRequest data) async {
    final response = await _apiProvider.postMethod('/report', data.toJson());
    print('report status: ${response.statusCode}');
    if(response.isOk){
      return Report.fromJson(response.body);
    } 
    return null; 
  }
}
