import 'package:json_annotation/json_annotation.dart';

part 'fee_data.g.dart';

@JsonSerializable()
class FeeData {
  /// Fee have to pay to publish a post
  @JsonKey(name: 'job_post')
  double postingFeePerDay;

  /// Total money have to pay to get 1 point
  @JsonKey(name: 'earn_point')
  double payToHave1Point;

  /// Point have to use to reduce 1 VND
  @JsonKey(name: 'point')
  double pointToReduce1VND;

  FeeData({
    this.postingFeePerDay = 0,
    this.payToHave1Point = 0,
    this.pointToReduce1VND = 0,
  });

  factory FeeData.fromJson(Map<String, dynamic> json) =>
      _$FeeDataFromJson(json);

  Map<String, dynamic> toJson() => _$FeeDataToJson(this);
}
