import 'package:crypto/crypto.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/environment.dart';
import 'package:myray_mobile/app/data/providers/momo/models/momo_payment_request.dart';
import 'package:myray_mobile/app/data/providers/momo/models/momo_payment_response.dart';
import 'dart:convert';

import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';

enum MomoRequestType {
  captureWallet,
}

class MomoProvider extends GetConnect {
  MomoProvider._();
  static final MomoProvider _instance = MomoProvider._();
  static MomoProvider get instance => _instance;

  static const String _url =
      'https://test-payment.momo.vn/v2/gateway/api/create';
  static final Codec<String, String> base64Convert = utf8.fuse(base64);
  static final hmacSha256 =
      Hmac(sha256, utf8.encode(Environment.momoSecretKey));

  Future<void> createPayment({
    required int amount,
    required String orderInfo,
    required String ipnUrl,
    required requestType,
    required redirectUrl,
    required Map<String, String> extraData,
  }) async {
    String id = _momoOrderId;
    String encodedExtraData = base64Convert.encode(json.encode(extraData));
    final params = MomoPaymentRequest(
      partnerCode: Environment.momoPartnerCode,
      requestId: id,
      orderId: id,
      orderInfo: orderInfo,
      redirectUrl: redirectUrl,
      ipnUrl: ipnUrl,
      extraData: encodedExtraData,
      amount: amount,
      signature: _createSignature(
        requestType: requestType,
        amount: amount,
        extraData: encodedExtraData,
        ipnUrl: ipnUrl,
        redirectUrl: redirectUrl,
        orderInfo: orderInfo,
        requestId: id,
        orderId: id,
      ),
      requestType: requestType,
    );

    String token = AuthCredentials.instance.getToken() ?? '';
    try {
      final response = await post(
        _url,
        params.toJson(),
        contentType: 'application/json; charset=utf-8',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.isOk) {
        final result = MomoPaymentResponse.fromJson(response.body);
        final webView = FlutterWebviewPlugin();
        webView.onUrlChanged.listen((url) {
          print(url);

          if (url.contains('myray://')) {
            webView.close();
            webView.dispose();
            Future.delayed(const Duration(milliseconds: 500)).then((value) {
              if (!Get.isSnackbarOpen) {
                CustomSnackbar.show(
                  title: AppStrings.titleError,
                  message: 'Nạp tiền thất bại',
                  backgroundColor: AppColors.errorColor,
                );
              }
            });
          }

          if (url.contains('momo://')) {
            Uri momoUri = Uri.parse(url);
            //launch momo app
            canLaunchUrl(momoUri).then((canLaunch) {
              if (canLaunch) {
                launchUrl(momoUri).then((value) {
                  webView.close();
                  webView.dispose();
                });
              }
            });
          }
        });
        webView.launch(result.payUrl);
      }
    } catch (e) {
      Future.delayed(const Duration(seconds: 500))
          .then((value) => CustomSnackbar.show(
                title: AppStrings.titleError,
                message: 'Nạp tiền thất bại',
                backgroundColor: AppColors.errorColor,
              ));
    }
  }

  String _createSignature({
    required int amount,
    required String extraData,
    required String orderId,
    required String orderInfo,
    required String redirectUrl,
    required String requestId,
    required String requestType,
    required String ipnUrl,
  }) {
    final signature = StringBuffer();
    signature.write('accessKey=${Environment.momoAccessKey}');
    signature.write('&amount=$amount');
    signature.write('&extraData=$extraData');
    signature.write('&ipnUrl=$ipnUrl');
    signature.write('&orderId=$orderId');
    signature.write('&orderInfo=$orderInfo');
    signature.write('&partnerCode=${Environment.momoPartnerCode}');
    signature.write('&redirectUrl=$redirectUrl');
    signature.write('&requestId=$requestId');
    signature.write('&requestType=$requestType');

    return hmacSha256.convert(utf8.encode(signature.toString())).toString();
  }

  String get _momoOrderId {
    DateTime now = DateTime.now();
    final orderId = StringBuffer();
    orderId.write('MYRAY-');
    orderId.write(now.year);
    orderId.write(now.month);
    orderId.write(now.day);
    orderId.write(now.second);
    orderId.write(now.millisecond);
    return orderId.toString();
  }
}
