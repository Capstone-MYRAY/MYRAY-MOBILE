import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:myray_mobile/app/modules/auth/controllers/enter_otp_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class EnterOtpView extends GetView<EnterOtpController> {
  const EnterOtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    AppAssets.otp,
                    width: Get.width * 0.6,
                    alignment: Alignment.topCenter,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: Get.width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.titleEnterOtp,
                          style: Get.textTheme.headline2,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${AppStrings.captionEnterOtp} ${controller.phone}',
                          style: Get.textTheme.caption,
                        ),
                        const SizedBox(height: 16),
                        OTPTextField(
                          length: 6,
                          width: double.infinity,
                          fieldWidth: 40,
                          fieldStyle: FieldStyle.box,
                          otpFieldStyle: OtpFieldStyle(
                            backgroundColor: AppColors.greyOtp,
                            borderColor: AppColors.greyOtp,
                            focusBorderColor: AppColors.primaryColor,
                            enabledBorderColor: AppColors.greyOtp,
                          ),
                          hasError: false,
                          outlineBorderRadius: CommonConstants.borderRadius,
                          style: Get.textTheme.bodyText1!,
                          textFieldAlignment: MainAxisAlignment.spaceBetween,
                          onChanged: (pin) {
                            controller.otp.value = pin;
                          },
                        ),
                        const SizedBox(height: 16),
                        Obx(
                          () =>
                              controller.start.value == CommonConstants.otpTimer
                                  ? _buildText(
                                      s1: 'Chưa nhận được mã? ',
                                      s2: AppStrings.titleResend,
                                      onTap: controller.resendOTP,
                                    )
                                  : _buildText(
                                      s1: 'Gửi lại sau ',
                                      s2: controller.start.value.toString(),
                                    ),
                        ),
                        const SizedBox(height: 24),
                        Obx(
                          () => ElevatedButton(
                            onPressed: controller.otp.value.length ==
                                    CommonConstants.otpNum
                                ? controller.onSubmit
                                : null,
                            child: const Text(AppStrings.titleConfirm),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(
      {required String s1, required String s2, Function()? onTap}) {
    return SizedBox(
      width: double.infinity,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Get.textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.w300,
          ),
          text: s1,
          children: <TextSpan>[
            TextSpan(
                text: s2,
                style: Get.textTheme.bodyText1!.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
                recognizer: TapGestureRecognizer()..onTap = onTap),
          ],
        ),
      ),
    );
  }
}
