import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_request.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_response.dart';
import 'package:myray_mobile/app/data/models/attendance/farmer_post_attendance_request.dart';
import 'package:myray_mobile/app/data/models/day_off/day_off.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/extend_end_date_job.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/get_extend_end_date_job_list_response.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/get_extend_end_date_job_request.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/post_extend_end_date_job_request.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/put_extend_end_date_request.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/update_end_date_job_response.dart';
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
        body: {'job_post_id': jobPostId});
    print(response.request!.url);
    return response.statusCode == HttpStatus.ok;
  }

  //report job for farmer
  Future<Report?> reportJob(PostReportRequest data) async {
    final response = await _apiProvider.postMethod('/report', data.toJson());
    print('report status: ${response.statusCode}');
    if (response.isOk) {
      return Report.fromJson(response.body);
    }
    return null;
  }

  // Extend end date task job
  Future<ExtendEndDateJob?> extendEndDateJob(
      PostExtendEndDateJobRequest data) async {
    final response =
        await _apiProvider.postMethod('/extendtaskjob', data.toJson());
    print('extend status: ${response.statusCode}');
    if (response.isOk) {
      return ExtendEndDateJob.fromJson(response.body);
    }
    return null;
  }

  Future<ExtendEndDateJob?> getExtendEndDateJob(int idJobPost) async {
    final response = await _apiProvider.getMethod('/extendtaskjob/$idJobPost');
    if (response.statusCode == HttpStatus.ok) {
      return ExtendEndDateJob.fromJson(response.body);
    }
    return null;
  }

  Future<GetExtendEndDateJobList?> getExtendEndDateJobList(
      GetExtendEndDateJobRequest data) async {
    final response =
        await _apiProvider.getMethod('/extendtaskjob', data: data.toJson());
    if (response.statusCode == HttpStatus.ok) {
      return GetExtendEndDateJobList.fromJson(response.body);
    }
    return null;
  }

  //cancel request extend end date job
  Future<bool?> canceExtendEndDate(int extendTaskId) async {
    final response = await _apiProvider.delete('/extendtaskjob/$extendTaskId');
    print('cancel extend date has error: ${response.hasError}');
    return response.isOk;
  }

  //update extend end date job
  Future<bool?> updateExtendEndDate(PutExtendEndDateRequest data) async {
    print('data: ${data.extendEndDate}');
    final response =
        await _apiProvider.putMethod('/extendtaskjob', data.toJson());
    if (response.isOk) {
      print(
          'ngay ket thuc moi: ${UpdateEndDateJobResponse.fromJson(response.body).extendEndDate}');
      return true;
    }
    return false;
  }

  //request day off
  Future<bool?> requestDayOff(FarmerPostAttendanceRequest data) async {
    final response =
        await _apiProvider.post('/attendance/dayoff', data.toJson());
    if (response.isOk) {
      return true;
    }
    return false;
  }

  //get day off list, no condition
  Future<List<DayOff>?> getDayOff() async {
    final response = await _apiProvider.getMethod('/attendance/dayoff');
    if(response.statusCode == HttpStatus.ok){
      final jsonList = response.body as List;
      return jsonList.map((dayOff) => DayOff.fromJson(dayOff)).toList();
    }
    return null;
  }

  Future<int?> countAppliedJob() async {
    final response = await _apiProvider.getMethod('$jobPostUrl/countapplied');
    if(response.statusCode == HttpStatus.ok){
      return response.body;
    }
    return null;
  }
}
