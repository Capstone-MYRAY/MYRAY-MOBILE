import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinkHandler {
  DeepLinkHandler._();
  static final DeepLinkHandler _instance = DeepLinkHandler._();
  static DeepLinkHandler get instance => _instance;

  static bool _initialUriIsHandled = false;

  static StreamSubscription? _sub;

  static Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          print('got initial uri: $uri');
        }
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        print('falied to get initial uri');
      } on FormatException catch (err) {
        print('malformed initial uri: $err');
      }
    }
  }

  static void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _sub = uriLinkStream.listen((Uri? uri) {
        print('got uri: $uri');
        if (uri != null) {
          print('uri != null');
          if (uri.host.contains('paymentResult') ||
              uri.host.contains('paymentresult')) {
            print(uri.queryParameters);
            String? resultCode = uri.queryParameters['resultCode'];
            if (resultCode == '9000' || resultCode == '0') {
              Get.back(); //close dialog
              Future.delayed(const Duration(seconds: 1)).then(
                (value) => CustomSnackbar.show(
                  title: AppStrings.titleSuccess,
                  message: 'Nạp tiền thành công',
                ),
              );
            }
          }
        }
      }, onError: (Object err) {
        print('got err: $err');
      });
    }
  }

  static void init() {
    _handleIncomingLinks();
    _handleInitialUri();
  }

  void dispose() {
    _sub?.cancel();
  }
}
