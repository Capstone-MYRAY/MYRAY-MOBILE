
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:myray_mobile/app/data/models/report/get_report_request.dart';
import 'package:myray_mobile/app/data/models/report/get_report_response.dart';
import 'package:myray_mobile/app/data/models/report/put_update_report_request.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class ReportRepository{

  ApiProvider _apiProvider = Get.find<ApiProvider>();
  final String _url = '/report';

  Future<GetReportResponse?> getReport(GetReportRequest data) async {
    final response = await _apiProvider.getMethod(_url, data: data.toJson());
    print('url: ${response.request!.url}');
    if(response.statusCode == HttpStatus.ok){
      return GetReportResponse.fromJson(response.body);
    }
    return null;
  }

  Future<Report?> updateReport(PutUpdateReportRequest data) async{
    final response = await _apiProvider.putMethod(_url, data.toJson()); 
    if(response.statusCode == HttpStatus.ok){
      return Report.fromJson(response.body);
    }
    return null;
  }
  
  Future<bool?> deleteReport(int reportId) async {
    final response = await _apiProvider.deleteMethod('$_url/$reportId');
    if(response.isOk){
      return true;
    }
    if(response.unauthorized || response.statusCode == HttpStatus.badRequest || response.statusCode == HttpStatus.internalServerError){
      printError();
      return false;
    }
    return null;
  }
}