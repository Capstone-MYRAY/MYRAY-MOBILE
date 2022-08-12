import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/home/widgets/landowner_current_job/landowner_current_start_jobs_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/feature_option.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class LandownerCurrentStartJobs extends StatelessWidget {
  LandownerCurrentStartJobs({Key? key}) : super(key: key) {
    Get.put(LandownerCurrentStartJobsController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandownerCurrentStartJobsController>(
      id: 'CurrentStartJobPost',
      builder: (controller) => FutureBuilder(
          future: controller.getCurrentStartJobs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MyLoadingBuilder();
            }

            if (snapshot.data == null) {
              return Container(
                margin: const EdgeInsets.only(top: 20.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.noJobFound),
                    const SizedBox(height: 4.0),
                    Text(
                      'Không có công việc nào',
                      style: Get.textTheme.bodyText1,
                    ),
                    const SizedBox(height: 8.0),
                    FractionallySizedBox(
                      widthFactor: 0.3,
                      child: FilledButton(
                        title: 'Tải lại',
                        onPressed: () => controller.onRefresh(),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                      ),
                    )
                  ],
                ),
              );
            }

            return _buildContent(controller);
          }),
    );
  }

  Widget _buildContent(LandownerCurrentStartJobsController controller) {
    return Obx(
      () {
        return LazyLoadingList(
          onEndOfPage: controller.getCurrentStartJobs,
          isLoading: controller.isLoading.value,
          onRefresh: controller.onRefresh,
          itemCount: controller.jobPosts.length,
          width: double.infinity,
          shrinkWrap: true,
          scrollPhysics: const NeverScrollableScrollPhysics(),
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
    );
  }
}
