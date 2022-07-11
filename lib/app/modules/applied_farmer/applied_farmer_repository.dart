import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer_models.dart';

import 'package:myray_mobile/app/data/providers/api/api_provider.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class AppliedFarmerRepository {
  final _apiProvider = Get.find<ApiProvider>();

  Future<GetAppliedFarmerResponse?> getList(
      GetAppliedFarmerRequest data) async {
    final response = await _apiProvider.getMethod('/jobpost/allapplied',
        data: data.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return GetAppliedFarmerResponse.fromJson(response.body);
    }

    if (response.statusCode == HttpStatus.noContent) {
      throw CustomException('No content');
    }

    return null;
  }

  Future<bool> approveFarmer(int appliedId) async {
    final response =
        await _apiProvider.patchMethod('/jobpost/approve/$appliedId');

    if (response.isOk) return true;

    return false;
  }

  Future<bool> rejectFarmer(int appliedId) async {
    final response =
        await _apiProvider.patchMethod('/jobpost/reject/$appliedId');

    if (response.isOk) return true;

    return false;
  }
}
