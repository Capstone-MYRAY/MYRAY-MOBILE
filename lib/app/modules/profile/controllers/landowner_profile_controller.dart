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
  var pointWithPending = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserInfo();
  }

  //balance in account minus balance fluctuation of pending payment histories
  calBalance() async {
    print(user.value.toJson());
    double balance = user.value.balance!;
    double pendingFee = 0.0;
    int point = user.value.point!;
    int pendingPoint = 0;

    final data = GetPaymentHistoryRequest(
      page: 1.toString(),
      pageSize: 100.toString(),
      status: PaymentHistoryStatus.pending.index.toString(),
    );
    int userId = AuthCredentials.instance.user!.id!;

    final response = await _paymentHistoryRepository.getList(userId, data);

    if (response == null) {
      setBalanceWithPending(balance, pendingFee);
      setPointWithPending(point, pendingPoint);
      return;
    }

    final paymentHistories = response.paymentHistories;

    if (paymentHistories != null) {
      if (paymentHistories.isEmpty) {
        setBalanceWithPending(balance, pendingFee);
        setPointWithPending(point, pendingPoint);
        return;
      }

      //calculate balance
      for (PaymentHistory payment in paymentHistories) {
        pendingFee += payment.balanceFluctuation ?? 0;
        pendingPoint += payment.usedPoint ?? 0;
      }
    }

    setBalanceWithPending(balance, pendingFee);
    setPointWithPending(point, pendingPoint);
  }

  setBalanceWithPending(double balance, double pendingFee) {
    //pending fee is a negative number
    balanceWithPending.value = balance + pendingFee;
  }

  setPointWithPending(int point, int pendingPoint) {
    pointWithPending.value = point - pendingPoint;
  }

  getUserInfo() async {
    Account? userInfo =
        await _profileRepository.getUser(AuthCredentials.instance.user!.id!);

    if (userInfo != null) {
      user.value = userInfo;
      await calBalance();
      update(['AppBar']);
    }
  }
}
