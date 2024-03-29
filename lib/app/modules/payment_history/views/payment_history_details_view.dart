import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history_models.dart';
import 'package:myray_mobile/app/modules/payment_history/payment_history_module.dart';
import 'package:myray_mobile/app/modules/payment_history/widgets/payment_basic_info.dart';
import 'package:myray_mobile/app/modules/payment_history/widgets/payment_details_info_card.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field_no_icon.dart';
import 'package:myray_mobile/app/shared/widgets/cards/feature_option.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';

class PaymentHistoryDetailsView
    extends GetView<PaymentHistoryDetailsController> {
  const PaymentHistoryDetailsView({Key? key}) : super(key: key);

  @override
  String get tag => Get.arguments[Arguments.tag];

  PaymentHistory get payment => controller.paymentHistory.value;

  bool get isDisplay {
    bool isHaveTotalPinDate =
        payment.totalPinDay != null && payment.totalPinDay != 0;
    bool isHaveUsedPoint = payment.usedPoint != null && payment.usedPoint != 0;
    return isHaveTotalPinDate || isHaveUsedPoint;
  }

  Activities? get _action => Get.arguments[Arguments.action];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.titlePaymentHistoryDetails)),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            _buildAboveCard(),
            if (isDisplay) ...[
              PaymentDetailsInfoCard(
                title: AppStrings.titlePaymentHistoryDetails,
                postingFee: payment.jobPostPrice ?? 0,
                numOfPostingDay: payment.numOfPublishDay ?? 0,
                pointFee: payment.pointPrice ?? 0,
                usedPoint: payment.usedPoint ?? 0,
                earnedPoint: payment.earnedPoint ?? 0,
                total: payment.balanceFluctuation ?? 0,
                numOfUpgradingDay: payment.totalPinDay,
                upgradingFee: payment.postTypePrice,
              ),
              const SizedBox(height: 8.0),
              if (_action == null || _action != Activities.view)
                FeatureOption(
                  icon: CustomIcons.post,
                  title: AppStrings.titlePostInformation,
                  onTap: controller.viewJobPostDetails,
                  widthFactor: 0.9,
                  borderRadius: CommonConstants.borderRadius,
                ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildAboveCard() {
    return MyCard(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              payment.message ?? '',
              style: Get.textTheme.headline6!.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          PaymentBasicInfo(
            iconColor: payment.statusColor,
            isMe: isDisplay,
            balanceFluctuation: payment.balanceFluctuation ?? 0,
            paymentId: payment.id.toString(),
          ),
          const SizedBox(height: 8.0),
          StatusChip(
            statusName: payment.statusString,
            backgroundColor: payment.statusColor,
            borderRadius: 20.0,
          ),
          const SizedBox(height: 24.0),
          CardFieldNoIcon(
            title: AppStrings.labelIssuedDate,
            data: Utils.formatHHmmddMMyyyy(payment.createdDate!),
          ),
          const SizedBox(height: 16.0),
          CardFieldNoIcon(
            title: AppStrings.labelIssuedPerson,
            data: payment.createdByName ?? '',
          ),
          const SizedBox(height: 16.0),
          CardFieldNoIcon(
            title: AppStrings.labelBalance,
            data: Utils.vietnameseCurrencyFormat.format(payment.balance),
          ),
        ],
      ),
    );
  }
}
