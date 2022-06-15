import 'package:get_storage/get_storage.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';

mixin StorageProvider {
  Future<bool> saveToken(String? token, String? refreshToken) async {
    final box = GetStorage(CommonConstants.appName);
    await box.write(StorageProviderKey.token.toString(), token);
    await box.write(StorageProviderKey.refreshToken.toString(), refreshToken);
    return true;
  }

  String? getToken() {
    final box = GetStorage(CommonConstants.appName);
    return box.read(StorageProviderKey.token.toString());
  }

  String? getRefreshToken() {
    final box = GetStorage(CommonConstants.appName);
    return box.read(StorageProviderKey.refreshToken.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage(CommonConstants.appName);
    await box.remove(StorageProviderKey.token.toString());
    await box.remove(StorageProviderKey.refreshToken.toString());
  }
}

enum StorageProviderKey { token, refreshToken }
