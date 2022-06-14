import 'package:get/instance_manager.dart';
import 'package:myray_mobile/app/data/providers/api/api_provider.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiProvider(), permanent: true);
  }
}
