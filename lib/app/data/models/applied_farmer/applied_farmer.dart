import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/account.dart';

part 'applied_farmer.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class AppliedFarmer {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'job_post')
  JobPost jobPost;

  @JsonKey(name: 'applied_date')
  DateTime appliedDate;

  @JsonKey(name: 'applied_by_navigation')
  Account userInfo;

  @JsonKey(name: 'status')
  int status;

  AppliedFarmer({
    required this.id,
    required this.jobPost,
    required this.userInfo,
    required this.appliedDate,
    required this.status,
  });

  factory AppliedFarmer.fromJson(Map<String, dynamic> json) =>
      _$AppliedFarmerFromJson(json);

  Map<String, dynamic> toJson() => _$AppliedFarmerToJson(this);
}
