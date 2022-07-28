import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/get_extend_end_date_job_request.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/get_extend_end_date_job_response.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class ExtendJobRepository {
  final _apiProvider = Get.find<ApiProvider>();
  static const String _url = '/extendtaskjob';

  Future<GetExtendEndDateJobResponse?> getList(
      GetExtendEndDateJobRequest data) async {
    final response = await _apiProvider.getMethod(_url, data: data.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return GetExtendEndDateJobResponse.fromJson(response.body);
    }

    if (response.statusCode == HttpStatus.noContent) {
      throw CustomException('No content');
    }

    return null;
  }

  Future<bool> approveExtend(int taskId) async {
    final response = await _apiProvider.patchMethod('$_url/approve/$taskId');

    if (response.isOk) return true;

    return false;
  }

  Future<bool> rejectExtend(int taskId) async {
    final response = await _apiProvider.patchMethod('$_url/reject/$taskId');

    if (response.isOk) return true;

    return false;
  }
}
