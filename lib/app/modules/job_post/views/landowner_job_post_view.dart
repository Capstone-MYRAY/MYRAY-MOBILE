import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_controller.dart';

import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/landowner_appbar.dart';
import 'package:myray_mobile/app/shared/widgets/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/status_chip.dart';

class LandownerJobPostView extends GetView<LandownerJobPostController> {
  const LandownerJobPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LandownerAppbar(
        title: Text(
          AppStrings.jobPost,
          textScaleFactor: 1,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () {
          controller.navigateToDetails();
        },
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyCard(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: StatusChip(
                        backgroundColor: AppColors.grey,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
