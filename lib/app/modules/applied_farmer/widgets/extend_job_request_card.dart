import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/extend_end_date_job.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_user_info.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';

class ExtendJobRequestCard extends StatelessWidget {
  final ExtendEndDateJob extendRequest;
  final void Function()? onReject;
  final void Function()? onApprove;

  const ExtendJobRequestCard({
    Key? key,
    required this.extendRequest,
    this.onApprove,
    this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 4,
                child: CardUserInfo(
                  fullName: extendRequest.requestedName ?? '',
                  phone: extendRequest.requestedPhone ?? '',
                  avatar: extendRequest.requestedAvatar,
                  radius: 30.0,
                ),
              ),
              const SizedBox(width: 20.0),
              Flexible(
                flex: 6,
                child: Column(
                  children: [
                    CardField(
                      icon: CustomIcons.briefcase_outline,
                      title: AppStrings.labelWorkName,
                      data: extendRequest.jobTitle ?? '',
                    ),
                    const SizedBox(height: 8.0),
                    CardField(
                      icon: CustomIcons.calendar_range,
                      title: 'Ngày kết thúc cũ',
                      data: Utils.formatddMMyyyy(extendRequest.oldEndDate),
                      isCenter: true,
                    ),
                    const SizedBox(height: 8.0),
                    CardField(
                      icon: CustomIcons.calendar_range,
                      title: 'Ngày kết thúc mới',
                      data: Utils.formatddMMyyyy(extendRequest.extendEndDate),
                      isCenter: true,
                      dataColor: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 8.0),
                    CardField(
                      icon: CustomIcons.content_paste,
                      title: 'Lý do',
                      data: extendRequest.reason,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          _buildBottom(),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    if (extendRequest.status == ExtendJobEndDateStatus.pending.index) {
      return _buildButtons();
    } else {
      return StatusChip(
        statusName: extendRequest.statusString ?? '',
        backgroundColor: extendRequest.statusColor,
      );
    }
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: Get.width * 0.3,
          child: FilledButton(
            title: 'Từ chối',
            color: AppColors.errorColor,
            onPressed: onReject,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
          ),
        ),
        SizedBox(
          width: Get.width * 0.3,
          child: FilledButton(
            title: 'Chấp nhận',
            onPressed: onApprove,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
          ),
        ),
      ],
    );
  }
}
