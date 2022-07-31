import 'package:json_annotation/json_annotation.dart';

part 'signup_request.g.dart';

@JsonSerializable(includeIfNull: true)
class SignupRequest {
  @JsonKey(name: 'role_id')
  int? roleId;

  @JsonKey(name: 'fullname')
  String? fullName;

  @JsonKey(name: 'date_of_birth')
  DateTime? dob;

  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  @JsonKey(name: 'password')
  String? password;

  SignupRequest({
    this.roleId,
    this.fullName,
    this.dob,
    this.phoneNumber,
    this.password,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}
