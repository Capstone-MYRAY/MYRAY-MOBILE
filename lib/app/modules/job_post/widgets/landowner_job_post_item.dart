import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/hex_color_extension.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';

class LandownerJobPostItem extends StatelessWidget {
  const LandownerJobPostItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: StatusChip(
              backgroundColor: HexColor.fromHex('8E8EA1'),
              foregroundColor: AppColors.white,
              statusName: 'Thường',
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'This is long long long title to check overflow',
            style: Get.textTheme.headline4,
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.map_marker_outline,
            title: AppStrings.labelAddress,
            data:
                '86/2 Nguyễn Thông, Phường 9, Quận 3, Thành phố Hồ Chí Minh, Việt Nam',
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.bulletin_board,
            title: AppStrings.labelWorkType,
            data: 'Làm công',
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.tree_outline,
            title: AppStrings.labelTreeType,
            data: 'Cây cao su',
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.calendar_range,
            title: AppStrings.labelPublishDate,
            data: '28/05/2022',
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.calendar_range,
            title: AppStrings.labelExpiryDate,
            data: '02/06/2022',
          ),
        ],
      ),
    );
  }
}
