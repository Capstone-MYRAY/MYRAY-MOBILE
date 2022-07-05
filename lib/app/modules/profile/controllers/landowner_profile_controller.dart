import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history_models.dart';
import 'package:myray_mobile/app/modules/payment_history/payment_history_repository.dart';
import 'package:myray_mobile/app/modules/profile/profile_repository.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';

class LandownerProfileController extends GetxController {
  final _profileRepository = Get.find<ProfileRepository>();
  final _paymentHistoryRepository = Get.find<PaymentHistoryRepository>();
  var user = Account().obs;
  var balanceWithPending = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserInfor();
  }

  //balance in account minus balance fluctuation of pending payment histories
  calBalance() async {
    double balance = user.value.balance!;
    double pendingFee = 0.0;

    final data = GetPaymentHistoryRequest(
      page: 1.toString(),
      pageSize: 100.toString(),
      status: PaymentHistoryStatus.pending.index.toString(),
    );
    int userId = AuthCredentials.instance.user!.id!;
    print(user.value.balance);
    final _response = await _paymentHistoryRepository.getList(userId, data);

    if (_response == null) {
      setBalanceWithPending(balance, pendingFee);
      return;
    }

    final _paymentHistories = _response.paymentHistories;

    if (_paymentHistories != null) {
      if (_paymentHistories.isEmpty) {
        setBalanceWithPending(balance, pendingFee);
        return;
      }

      //calculate balance
      for (PaymentHistory payment in _paymentHistories) {
        pendingFee += payment.balanceFluctuation ?? 0;
      }
    }

    print(pendingFee);

    //pending fee is a negative number
    setBalanceWithPending(balance, pendingFee);
  }

  setBalanceWithPending(double balance, double pendingFee) {
    balanceWithPending.value = balance + pendingFee;
  }

  getUserInfor() async {
    user = Account().obs;
    balanceWithPending.value = 0.0;
    Account? _user =
        await _profileRepository.getUser(AuthCredentials.instance.user!.id!);

    if (_user != null) {
      user.value = _user;
      await calBalance();
    }
  }
}
