import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_not_start_job_controller.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_not_start_job/farmer_not_start_job_card.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class FarmerNotStartJobList extends GetView<FarmerNotStartJobController> {
  const FarmerNotStartJobList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getNotStartJobList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyLoadingBuilder();
          }
          if (snapshot.hasError) {
            printError(info: snapshot.error.toString());
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error,
                    size: 50.0,
                    color: AppColors.errorColor,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Đã có lỗi xảy ra',
                    style: Get.textTheme.headline6!.copyWith(
                      color: AppColors.errorColor,
                    ),
                  ),
                ],
              ),
            );
          }
          return Obx(() => LazyLoadingList(
                onEndOfPage: controller.getNotStartJobList,
                onRefresh: controller.onRefresh,
                itemCount: controller.notStartJobPostList.isEmpty
                    ? 1
                    : controller.notStartJobPostList.length,
                itemBuilder: (context, index) {
                  if (snapshot.data == null ||
                      controller.notStartJobPostList.isEmpty) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.3),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "Không có công việc nào.",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                color: AppColors.grey,
                                fontSize: Get.textScaleFactor * 20,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const ImageIcon(AssetImage(AppAssets.noJobFound),
                                size: 30, color: AppColors.grey),
                          ],
                        ),
                      ),
                    );
                  }
                  JobPost jobPost =
                      controller.notStartJobPostList[index].jobPost;
                  return Container(
                    padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
                    child: FarmerNotStartJobCard(
                      title: jobPost.title,
                      address: jobPost.address ?? 'Đang cập nhật',
                      startDate:
                          Utils.formatddMMyyyy(jobPost.jobStartDate),
                      // confirm: () => controller.cancelAppliedJob(jobPost.id),
                      // message: 'Bạn muốn hủy công việc đã được tuyển ?',
                      jobPost: jobPost
                    ),
                  );
                },
              ));
        });
  }
}
