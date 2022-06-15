import 'package:jwt_decode/jwt_decode.dart';
import 'package:myray_mobile/app/data/providers/storage_provider.dart';

class _User {
  String? role;
  String? phone;
  int? id;

  _User({this.role, this.phone, this.id});

  factory _User.fromJson(Map<String, dynamic> json) => _User(
        id: int.parse(json['id']),
        phone: json['phone'] as String?,
        role: json['role'] as String?,
      );
}

class AuthCredentials with StorageProvider {
  AuthCredentials._();
  static final AuthCredentials _instance = AuthCredentials._();
  static AuthCredentials get instance => _instance;

  _User? user;

  void updateUserInfor() {
    String? token = getToken();
    Map<String, dynamic> payload = Jwt.parseJwt(token!);
    user = _User.fromJson(payload);
  }

  void clearUserInfor() {
    user = null;
  }

  DateTime? getTokenExpiryDate() {
    String? token = getToken();
    DateTime? expiryDate = Jwt.getExpiryDate(token!);
    print('token: $expiryDate');
    return expiryDate;
  }

  bool isTokenExpired() {
    String? token = getToken();
    bool result = Jwt.isExpired(token!);
    print('Token expired: $token');
    return result;
  }
}
