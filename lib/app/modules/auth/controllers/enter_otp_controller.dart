import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/activities.dart';
import 'package:myray_mobile/app/data/providers/firebase_provider.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class EnterOtpController extends GetxController {
  late String phone;
  var otp = ''.obs;
  var start = CommonConstants.otpTimer.obs;
  Timer? _timer;
  Activities action = Activities.signup;

  @override
  void onInit() {
    super.onInit();
    phone = Get.arguments[Arguments.phone];
    action = Get.arguments[Arguments.action];
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
      EasyLoading.show(status: AppStrings.loading);
      await FirebaseProvider.instance.verify(otp: otp.value);
      EasyLoading.dismiss();
      if (_timer != null) {
        _timer!.cancel();
      }

      if (action == Activities.signup) {
        Get.toNamed(Routes.enterPassword);
      } else if (action == Activities.reset) {
        Get.offAllNamed(Routes.init);
      }
    } on Exception catch (e) {
      EasyLoading.dismiss();
      if (e.toString().contains('Wrong OTP')) {
        CustomSnackbar.show(title: 'Error', message: AppMsg.MSG6008);
      }
    }
  }
}
