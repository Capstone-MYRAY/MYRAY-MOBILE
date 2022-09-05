import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/providers/notification/notification_provider.dart';
import 'package:myray_mobile/app/data/providers/signalR_provider.dart';
import 'package:myray_mobile/app/data/providers/storage_provider.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/user_current_location.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class AuthController extends GetxController with StorageProvider {
  final isLogged = false.obs;

  void logOut() async {
    removeToken();

    //unsubscribe topic
    String topic = AuthCredentials.instance.user!.id.toString();

    AuthCredentials.instance.clearUserInfor();
    //disconnect from hub when logout
    SignalRProvider.instance.stopHub();
    Get.deleteAll();
    isLogged.value = false;
    NotificationProvider.instance.unsubscribeTopic(topic);
  }

  Future<void> login(String token, String refreshToken) async {
    await saveToken(token, refreshToken);
    AuthCredentials.instance.updateUserInfor();
    await NotificationProvider.instance
        .subscribeTopic(AuthCredentials.instance.user!.id.toString());
    await _getUserLocation();
    isLogged.value = true;
  }

  Future _getUserLocation() async {
    if (Utils.equalsIgnoreCase(
        Roles.farmer.name, AuthCredentials.instance.user!.role!)) {
      await CurrentLocation.instance.saveUserCurrentLocation();
    }
  }

  Future<void> checkLoginStatus() async {
    final token = getToken();
    if (token != null) {
      AuthCredentials.instance.updateUserInfor();
      await NotificationProvider.instance
          .subscribeTopic(AuthCredentials.instance.user!.id.toString());
      await _getUserLocation();
      isLogged.value = true;
    } else {
      isLogged.value = false;
    }
  }
}
