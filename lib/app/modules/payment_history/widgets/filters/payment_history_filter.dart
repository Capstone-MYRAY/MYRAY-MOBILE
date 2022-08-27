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
  PaymentHistoryFilter({Key? key}) : super(key: key) {
    _selectedDate = controller.rangeDate;
  }

  final statusKey = GlobalKey<OutlinedFilterState>();
  final issuedDateController = TextEditingController();
  DateTimeRange? _selectedDate;

  @override
  Widget build(BuildContext context) {
    print('Payment filter build');
    controller.setDateRangeText(_selectedDate, issuedDateController);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleFilter),
        leading: GestureDetector(
          onTap: () {
            controller.isClearFilter = false;
            Get.back();
          },
          child: const Icon(Icons.arrow_back_outlined),
        ),
      ),
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
            onApply: () {
              if (controller.isClearFilter) {
                controller.isClearFilter = false;
                statusKey.currentState?.clearFilter();
                controller.onClearFilter();
              } else {
                controller.rangeDate = _selectedDate;
                print(controller.rangeDate == null);
                // controller.setDateRangeText(
                //     selectedDate, controller.issuedDateController);
                controller.statusFilter =
                    statusKey.currentState?.getSelectedItem();
              }
              controller.onApplyFilter();
            },
            onClear: () {
              statusKey.currentState!.clearFilter();
              issuedDateController.clear();
              controller.isClearFilter = true;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilter() {
    return FilterSection(
      title: 'Trạng thái',
      child: OutlinedFilter(
        key: statusKey,
        // onChanged: (value) {
        //   controller.statusFilter = value;
        // },
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
        controller: issuedDateController,
        readOnly: true,
        onTap: () async {
          DateTimeRange? selectedDate = await controller.onChooseIssuedDate();
          if (selectedDate != null) {
            _selectedDate = selectedDate;
          }
          controller.setDateRangeText(_selectedDate, issuedDateController);
        },
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
