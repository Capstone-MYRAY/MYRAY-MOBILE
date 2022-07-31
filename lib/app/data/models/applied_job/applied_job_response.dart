
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';

part 'applied_job_response.g.dart';

@JsonSerializable(includeIfNull: false)
class AppliedJobResponse {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'job_post')
  JobPost jobPost;

  @JsonKey(name: 'applied_date')
  DateTime appliedDate;

  @JsonKey(name: 'applied_by_navigation')
  Account appliedByNavigation;

  AppliedJobResponse({
    required this.id,
    required this.jobPost,
    required this.appliedDate,
    required this.appliedByNavigation,
  });

  factory AppliedJobResponse.fromJson(Map<String, dynamic> json) => _$AppliedJobResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AppliedJobResponseToJson(this);
}