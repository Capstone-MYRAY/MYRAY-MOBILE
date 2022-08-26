import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance_models.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance_response.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class AttendanceRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final _url = '/attendance';

  Future<List<GetAttendanceByDateResponse>?> getList(
      GetAttendanceByDateRequest data) async {
    final response =
        await _apiProvider.getMethod('$_url/day', data: data.toJson());
    print(response.bodyString);
    if (response.isOk) {
      final jsonList = response.body as List;
      return jsonList
          .map((json) => GetAttendanceByDateResponse.fromJson(json))
          .toList();
    }

    return null;
  }

  Future<Attendance?> checkAttendance(CheckAttendanceRequest data) async {
    final response = await _apiProvider.postMethod(_url, data.toJson());
    print(response.bodyString);
    if (response.isOk) {
      return Attendance.fromJson(response.body);
    }
    return null;
  }

  Future<Attendance?> checkPayPerTaskAttendance(
      CheckAttendanceRequest data) async {
    final response = await _apiProvider.postMethod('$_url/task', data.toJson());
    print(response.bodyString);
    if (response.isOk) {
      return Attendance.fromJson(response.body);
    }
    return null;
  }

  Future<List<AttendanceResponse>?> getAttendanceList(
      GetAttendanceRequest data) async {
    final response = await _apiProvider.getMethod(_url, data: data.toJson());
    if (response.statusCode == HttpStatus.ok) {
      final jsonList = response.body as List;
      print('length of attendances: ${jsonList.length}');
      return jsonList.map((json) => AttendanceResponse.fromJson(json)).toList();
    }
    return null;
  }

  Future<List<Attendance>?> getAttendanceByAccountAndJobPostId(
      GetAttendanceRequest data) async {
    final response = await _apiProvider.getMethod(_url, data: data.toJson());
    if (response.isOk) {
      final jsonList = response.body as List;
      return jsonList.map((json) => Attendance.fromJson(json)).toList();
    }

    return null;
  }

  Future<double?> getTotalExpense(int jobPostId) async {
    final response =
        await _apiProvider.getMethod('$_url/totalexpense/$jobPostId');
    if (response.isOk) {
      return response.body;
    }

    return null;
  }
}
