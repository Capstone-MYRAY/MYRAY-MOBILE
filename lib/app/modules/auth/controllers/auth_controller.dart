import 'package:get/get.dart';
import 'package:myray_mobile/app/data/providers/signalR_provider.dart';
import 'package:myray_mobile/app/data/providers/storage_provider.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';

class AuthController extends GetxController with StorageProvider {
  final isLogged = false.obs;

  void logOut() {
    isLogged.value = false;
    removeToken();
    AuthCredentials.instance.clearUserInfor();
  }

  Future<void> login(String token, String refreshToken) async {
    await saveToken(token, refreshToken);
    //connect to hub
    await SignalRProvider.instance.connectToHub();
    AuthCredentials.instance.updateUserInfor();
    isLogged.value = true;
  }

  Future<void> checkLoginStatus() async {
    final token = getToken();
    if (token != null) {
      //connect to hub
      await SignalRProvider.instance.connectToHub();
      AuthCredentials.instance.updateUserInfor();
      isLogged.value = true;
    } else {
      isLogged.value = false;
    }
  }
}
