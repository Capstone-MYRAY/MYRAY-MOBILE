import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/attendance/get_attendance_by_date_request.dart';
import 'package:myray_mobile/app/data/models/attendance/get_attendance_by_date_response.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class AttendanceRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final _url = '/attendance';

  Future<List<GetAttendanceByDateResponse>?> getList(
      GetAttendanceByDateRequest data) async {
    final response =
        await _apiProvider.getMethod('$_url/day', data: data.toJson());
    if (response.isOk) {
      final jsonList = response.body as List;
      return jsonList
          .map((json) => GetAttendanceByDateResponse.fromJson(json))
          .toList();
    }

    return null;
  }
}
