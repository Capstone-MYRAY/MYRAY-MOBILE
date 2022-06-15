import 'dart:async';

import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/activities.dart';
import 'package:myray_mobile/app/data/providers/firebase_provider.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class EnterOtpController extends GetxController {
  late String phone;
  var otp = ''.obs;
  var start = CommonConstants.otpTimer.obs;
  Timer? _timer;
  Activities action = Activities.signup;

  @override
  void onInit() {
    super.onInit();
    phone = Get.arguments['phone'];
    action = Get.arguments['action'];
    if (action == Activities.signup) {
      _getOtp();
    }
  }

  _getOtp() {
    if (action == Activities.signup) {
      FirebaseProvider.instance.fetchOtp(phoneNumber: phone);
    }
  }

  resendOTP() async {
    if (action == Activities.signup) {
      _getOtp();
    }

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (start.value == 0) {
        timer.cancel();
        start.value = CommonConstants.otpTimer;
      } else {
        start.value--;
      }
    });
  }

  onSubmit() async {
    try {
      await FirebaseProvider.instance.verify(otp: otp.value);
      if (_timer != null) {
        _timer!.cancel();
      }

      if (action == Activities.signup) {
        Get.toNamed(Routes.enterPassword);
      } else if (action == Activities.reset) {
        Get.offAllNamed(Routes.login);
      }
    } on Exception catch (e) {
      if (e.toString().contains('Wrong OTP')) {
        Get.snackbar('Error', AppMsg.MSG6008);
      }
    }
  }
}
