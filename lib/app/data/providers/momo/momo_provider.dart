import 'package:momo_vn/momo_vn.dart';
import 'package:myray_mobile/app/data/environment.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class MomoProvider {
  final MomoVn _momoPay = MomoVn();

  MomoProvider._();
  static final MomoProvider _instance = MomoProvider._();
  static MomoProvider get instance => _instance;

  void onInit({
    required Function(PaymentResponse response) handlePaymentSuccess,
    required Function(PaymentResponse response) handlePaymentError,
  }) {
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, handlePaymentError);
  }

  void onClear() {
    _momoPay.clear();
  }

  void createPayment({required int amount}) {
    MomoPaymentInfo options = MomoPaymentInfo(
      appScheme: Environment.momoIOSAppScheme,
      merchantName: CommonConstants.appName,
      merchantCode: Environment.momoPartnerCode,
      merchantNameLabel: 'Nạp tiền vào ${CommonConstants.appName}',
      partnerCode: Environment.momoPartnerCode,
      partner: 'Diệp nguyễn',
      amount: amount,
      orderId: _momoOrderId,
      orderLabel: 'Nạp tiền vào tài khoản',
      description: 'Nạp tiền vào tài khoản MYRAY',
      fee: 0,
      isTestMode: true,
    );

    try {
      _momoPay.open(options);
    } catch (e) {
      rethrow;
    }
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
