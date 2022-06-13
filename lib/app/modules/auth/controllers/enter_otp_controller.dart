import 'dart:async';

import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/activities.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class EnterOtpController extends GetxController {
  late String phone;
  var otp = ''.obs;
  var start = CommonConstants.otpTimer.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    phone = Get.arguments['phone'];
  }

  resendOTP() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (start.value == 0) {
        timer.cancel();
        start.value = 30;
      } else {
        start.value--;
      }
    });
  }

  onSubmit() {
    if (_timer != null) {
      _timer!.cancel();
    }
    if (Get.arguments['action'] == Activities.signup) {
      Get.toNamed(Routes.enterPassword);
    } else if (Get.arguments['action'] == Activities.reset) {
      Get.offAllNamed(Routes.login);
    }
  }
}
