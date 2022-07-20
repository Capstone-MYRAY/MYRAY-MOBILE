import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/home/widgets/landowner_current_job/landowner_current_start_jobs_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/cards/feature_option.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class LandownerCurrentStartJobs extends StatelessWidget {
  LandownerCurrentStartJobs({Key? key}) : super(key: key) {
    Get.put(LandownerCurrentStartJobsController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandownerCurrentStartJobsController>(
      builder: (controller) => FutureBuilder(
          future: controller.getCurrentStartJobs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingBuilder();
            }

            if (snapshot.data == null) {
              return Text(
                'Không có công việc nào',
                style: Get.textTheme.bodyText2,
              );
            }

            return _buildContent(controller);
          }),
    );
  }

  Widget _buildContent(LandownerCurrentStartJobsController controller) {
    return Expanded(
      child: Obx(
        () {
          return LazyLoadingList(
            onEndOfPage: controller.getCurrentStartJobs,
            isLoading: controller.isLoading.value,
            onRefresh: controller.onRefresh,
            itemCount: controller.jobPosts.length,
            width: double.infinity,
            itemBuilder: (context, index) {
              final currentJob = controller.jobPosts[index];
              return FeatureOption(
                icon: CustomIcons.briefcase,
                title: currentJob.title,
                widthFactor: 1,
                borderRadius: CommonConstants.borderRadius,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                onTap: () =>
                    controller.navigateToCheckAttendanceScreen(currentJob),
              );
            },
          );
        },
      ),
    );
  }
}
