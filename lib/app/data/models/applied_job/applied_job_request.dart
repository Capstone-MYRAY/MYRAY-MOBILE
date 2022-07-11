
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
part 'applied_job_request.g.dart';

@JsonSerializable(includeIfNull: false)
class AppliedJobRequest{

  @JsonKey(name: 'status')
  AppliedJobStatus? status;

  @JsonKey(name: 'page')
  String page;

  @JsonKey(name: 'page-size')
  String pageSize;

  @JsonKey(name: 'startWork')
  String? startWork;
   
   AppliedJobRequest({
    this.status,
    this.startWork,
    required this.page,
    required this.pageSize,
   });

   factory AppliedJobRequest.fromJson(Map<String, dynamic> json) => _$AppliedJobRequestFromJson(json);
   Map<String, dynamic> toJson() => _$AppliedJobRequestToJson(this);
}