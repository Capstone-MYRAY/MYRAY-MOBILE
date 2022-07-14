import 'package:get/get.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';

class FarmerMessageController extends GetxController {
  navigateToP2PMessageScreen() {
    Get.toNamed(Routes.p2pMessages, arguments: {
      Arguments.from: AuthCredentials.instance.user!.id,
      Arguments.to: 33, //TODO: fix later
      Arguments.jobPostId: 1036,
    });
  }
}
