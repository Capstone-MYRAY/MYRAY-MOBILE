
import 'package:json_annotation/json_annotation.dart';
part 'change_password.g.dart';

@JsonSerializable(includeIfNull: false)
class ChangePassword{
  @JsonKey(name: 'password')
  String password;

  ChangePassword({
    required this.password
  });

  factory ChangePassword.fromJson(Map<String, dynamic> json) => _$ChangePasswordFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordToJson(this);
}