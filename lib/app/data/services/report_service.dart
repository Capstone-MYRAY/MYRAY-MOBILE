
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/report/get_report_request.dart';
import 'package:myray_mobile/app/data/models/report/get_report_response.dart';
import 'package:myray_mobile/app/data/models/report/post_report_request.dart';
import 'package:myray_mobile/app/data/models/report/put_update_report_request.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
import 'package:myray_mobile/app/modules/report/report_repository.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

mixin ReportService{
  final _reportRepository = Get.find<ReportRepository>();

  Future<GetReportResponse?> getReport(GetReportRequest data) async {
    return await _reportRepository.getReport(data);
  }

  String? validateReason(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng nhập lý do';
    }
    if (!Utils.limitString.hasMatch(value!)) {
      return 'Bạn đã nhập quá 1000 từ';
    }

    return null;
  }

  Future<Report?> updateReport(PutUpdateReportRequest data) async {
    return await _reportRepository.updateReport(data);
  }

  Future<Report?> reportJob(PostReportRequest reportData) async {
    return await _reportRepository.report(reportData);
  }
}