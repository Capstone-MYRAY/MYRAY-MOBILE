import 'package:myray_mobile/app/data/models/request/signup_request.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class AuthRepository {
  final ApiProvider apiProvider;

  AuthRepository({required this.apiProvider});

  Future<bool> signup(SignupRequest data) async {
    final response = await apiProvider.postMethod(
        path: '/Authentication/signup', data: data);
    if (response.isOk) return true;
    return false;
  }
}
