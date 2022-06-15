import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable(includeIfNull: false)
class Account {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'role_id')
  int? roleId;

  @JsonKey(name: 'fullname')
  String? fullName;

  @JsonKey(name: 'image_url')
  String? imageUrl;

  @JsonKey(name: 'date_of_birth')
  DateTime? dob;

  @JsonKey(name: 'gender')
  int? gender;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'balance', defaultValue: 0)
  int? balance;

  @JsonKey(name: 'point', defaultValue: 0)
  int? point;

  @JsonKey(name: 'about_me')
  String? aboutMe;

  Account({
    this.id,
    this.roleId,
    this.fullName,
    this.imageUrl,
    this.gender,
    this.address,
    this.dob,
    this.phoneNumber,
    this.email,
    this.balance,
    this.point,
    this.aboutMe,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
