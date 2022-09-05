import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history.dart';
import 'package:myray_mobile/app/modules/payment_history/controllers/payment_history_home_controller.dart';
import 'package:myray_mobile/app/modules/payment_history/widgets/filters/payment_history_filter.dart';
import 'package:myray_mobile/app/modules/payment_history/widgets/payment_history_item.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/controls/search_and_filter.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class PaymentHistoryHomeView extends GetView<PaymentHistoryHomeController> {
  const PaymentHistoryHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titlePaymentHistory),
      ),
      body: Column(
        children: [
          SearchAndFilter(
            searchController: controller.messageController,
            refreshOnClear: true,
            onTextChanged: (value) {
              controller.messageFilter = value;
              controller.onRefresh();
            },
            onFilterTap: () {
              Get.to(() => PaymentHistoryFilter());
            },
          ),
          Expanded(
            child: GetBuilder<PaymentHistoryHomeController>(
              builder: (_) => FutureBuilder(
                future: controller.getPaymentHistories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const MyLoadingBuilder();
                  }

                  if (snapshot.data == null) {
                    return ListEmptyBuilder(
                      onRefresh: controller.onRefresh,
                      msg: AppMsg.MSG4031,
                    );
                  }

                  if (snapshot.hasData) {
                    return GestureDetector(
                      onPanDown: (_) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: _buildContent(),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Obx(
      () => LazyLoadingList(
        width: double.infinity,
        onEndOfPage: controller.getPaymentHistories,
        onRefresh: controller.onRefresh,
        itemCount: controller.paymentHistories.length,
        itemBuilder: (context, index) {
          PaymentHistory payment = controller.paymentHistories[index];
          return PaymentHistoryItem(
            key: ValueKey(payment.id),
            issuedDate: payment.createdDate ?? DateTime.now(),
            balance: payment.balance ?? 0,
            point: payment.earnedPoint ?? 0,
            balanceFluctuation: payment.balanceFluctuation ?? 0,
            iconColor: payment.statusColor,
            title: payment.message ?? '',
            onTap: () {
              Get.toNamed(
                Routes.paymentHistoryDetails,
                arguments: {
                  Arguments.tag: payment.id.toString(),
                  Arguments.item: payment,
                },
              );
            },
          );
        },
      ),
    );
  }
}
