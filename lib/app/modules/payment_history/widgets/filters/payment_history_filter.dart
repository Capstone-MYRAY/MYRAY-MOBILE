import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/status.dart';
import 'package:myray_mobile/app/data/models/filter_object.dart';
import 'package:myray_mobile/app/modules/payment_history/controllers/payment_history_controllers.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/filters/filter_controls.dart';
import 'package:myray_mobile/app/shared/widgets/filters/filter_section.dart';
import 'package:myray_mobile/app/shared/widgets/filters/outlined_filter.dart';

class PaymentHistoryFilter extends GetView<PaymentHistoryHomeController> {
  const PaymentHistoryFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.titleFilter)),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildDateRangeFilter(),
                _buildStatusFilter(),
              ],
            ),
          ),
          FilterControls(
            onApply: controller.onApplyFilter,
            onClear: controller.onClearFilter,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilter() {
    return FilterSection(
      title: 'Trạng thái',
      child: OutlinedFilter(
        key: controller.statusKey,
        onChanged: (value) {
          controller.statusFilter = value;
        },
        selectedItem: controller.statusFilter,
        items: [
          FilterObject(
            name: 'Tất cả',
            value: null,
          ),
          FilterObject(
            name: AppStrings.paymentHistoryPending,
            value: PaymentHistoryStatus.pending.index,
          ),
          FilterObject(
            name: AppStrings.paymentHistorySuccess,
            value: PaymentHistoryStatus.paid.index,
          ),
          FilterObject(
            name: AppStrings.paymentHistoryFailed,
            value: PaymentHistoryStatus.rejected.index,
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangeFilter() {
    return FilterSection(
      title: 'Theo thời gian',
      child: TextField(
        controller: controller.issuedDateController,
        readOnly: true,
        onTap: controller.onChooseIssuedDate,
        decoration: InputDecoration(
          hintText: AppStrings.placeholderIssuedDate,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
            borderSide: const BorderSide(color: AppColors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
            borderSide: const BorderSide(color: AppColors.black),
          ),
          prefixIcon: const Icon(CustomIcons.calendar_range),
        ),
      ),
    );
  }
}
