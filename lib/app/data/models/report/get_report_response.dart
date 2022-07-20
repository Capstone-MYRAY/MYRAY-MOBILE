import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
part 'get_report_response.g.dart';

@JsonSerializable(includeIfNull: false)
class GetReportResponse{

@JsonKey(name: 'list_object')
List<Report>? listObject;

@JsonKey(name: 'paging_metadata')
PagingMetadata? pagingMetadata;

GetReportResponse({
  this.listObject,
  this.pagingMetadata
});

factory GetReportResponse.fromJson(Map<String, dynamic> json) => _$GetReportResponseFromJson(json);
Map<String, dynamic> toJson() => _$GetReportResponseToJson(this);

}