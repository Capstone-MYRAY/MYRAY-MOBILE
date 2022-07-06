import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history.dart';
import 'package:myray_mobile/app/modules/payment_history/controllers/payment_history_home_controller.dart';
import 'package:myray_mobile/app/modules/payment_history/widgets/payment_history_item.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/controls/search_and_filter.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class PaymentHistoryHomeView extends GetView<PaymentHistoryHomeController> {
  const PaymentHistoryHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(Utils.formatHHmmddMMyyyy(DateTime.now()));
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titlePaymentHistory),
      ),
      body: FutureBuilder(
        future: controller.getPaymentHistories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBuilder();
          }

          if (snapshot.data == null) {
            return ListEmptyBuilder(
              onRefresh: controller.onRefresh,
              msg: 'Bạn chưa thực hiện giao dịch nào',
            );
          }

          if (snapshot.hasData) {
            return _buildContent();
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        SearchAndFilter(onFilterTap: () {}),
        Obx(
          () => Expanded(
            child: LazyLoadingList(
              width: double.infinity,
              onEndOfPage: controller.getPaymentHistories,
              onRefresh: controller.onRefresh,
              itemCount: controller.paymentHistories.length,
              itemBuilder: (context, index) {
                PaymentHistory payment = controller.paymentHistories[index];
                return PaymentHistoryItem(
                  issuedDate: payment.createdDate ?? DateTime.now(),
                  balance: payment.balance ?? 0,
                  point: payment.earnedPoint ?? 0,
                  balanceFructuation: payment.balanceFluctuation ?? 0,
                  iconColor: payment.statusColor,
                  title: payment.message ?? '',
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
