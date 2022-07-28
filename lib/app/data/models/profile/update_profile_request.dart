import 'package:json_annotation/json_annotation.dart';

part 'update_profile_request.g.dart';

@JsonSerializable(includeIfNull: false)
class UpdateProfileRequest {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'role_id')
  int roleId;

  @JsonKey(name: 'fullname')
  String fullName;

  @JsonKey(name: 'image_url')
  String? avatar;

  @JsonKey(name: 'date_of_birth')
  DateTime dob;

  @JsonKey(name: 'gender')
  int gender;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'phone_number')
  String phone;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'about_me')
  String? aboutMe;

  UpdateProfileRequest({
    required this.id,
    required this.roleId,
    required this.fullName,
    required this.dob,
    required this.gender,
    required this.phone,
    this.aboutMe,
    this.email,
    this.address,
    this.avatar,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
