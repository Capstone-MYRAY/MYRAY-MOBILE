import 'package:flutter/material.dart';
import 'package:myray_mobile/app/modules/payment_history/widgets/payment_history_item.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/controls/search_and_filter.dart';

class PaymentHistoryHomeView extends StatelessWidget {
  const PaymentHistoryHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titlePaymentHistory),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        SearchAndFilter(onFilterTap: () {}),
        PaymentHistoryItem(),
        PaymentHistoryItem(),
        PaymentHistoryItem(),
      ],
    );
  }
}
