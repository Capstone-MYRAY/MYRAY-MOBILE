import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/home/widgets/landowner_current_job/landowner_current_start_jobs.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class LandownerCurrentStartJobsSection extends StatelessWidget {
  const LandownerCurrentStartJobsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Công việc đang bắt đầu',
            style: Get.textTheme.headline5!.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          LandownerCurrentStartJobs(),
        ],
      ),
    );
  }
}
