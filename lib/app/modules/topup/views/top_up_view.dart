import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/topup/controllers/top_up_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';

class TopUpView extends GetView<TopUpController> {
  const TopUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleTopUp),
      ),
      body: Align(
        alignment: Alignment.center,
        child: MyCard(
          isForm: true,
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputField(
                  controller: controller.topUpMoneyController,
                  icon: const Icon(CustomIcons.wallet_outline),
                  labelText: 'Số tiền',
                  placeholder: AppStrings.placeholderTopUp,
                  keyBoardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: controller.validateTopUpMoney,
                ),
                const SizedBox(height: 24.0),
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: FilledButton(
                    title: AppStrings.titleTopUp,
                    onPressed: controller.onTopUp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
