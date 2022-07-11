import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/genders.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

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

  @JsonKey(name: 'rating')
  double? rating;

  @JsonKey(name: 'balance', defaultValue: 0)
  double? balance;

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
    this.rating,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  String get roleName => roleId == CommonConstants.landownerRoleId
      ? AppStrings.landowner
      : AppStrings.farmer;

  String get genderString => _genders[gender] ?? AppStrings.other;
}

Map<int, String> _genders = {
  Genders.male.index: AppStrings.male,
  Genders.female.index: AppStrings.female,
  Genders.other.index: AppStrings.other,
};
