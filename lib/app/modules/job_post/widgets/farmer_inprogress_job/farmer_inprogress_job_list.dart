import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_inprogress_job_controller.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_job/farmer_inprogress_job_card.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class FarmerInprogressJobList extends GetView<FarmerInprogressJobController> {
  const FarmerInprogressJobList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getInProgressJobList(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBuilder();
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
              onEndOfPage: controller.getInProgressJobList,
              isLoading: controller.isLoading.value,
              onRefresh: controller.onRefresh,
              itemCount: controller.inProgressJobPostList.isEmpty
                  ? 1
                  : controller.inProgressJobPostList.length,
              itemBuilder: (context, index) {
                if (snapshot.data == null ||
                    controller.inProgressJobPostList.isEmpty) {
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
                    controller.inProgressJobPostList[index].jobPost;
                bool isPayPerHourJob = jobPost.payPerHourJob != null;
                return Container(
                    padding: const EdgeInsets.all(8),
                    child: FarmerInprogressJobCard(
                        job: jobPost.title,
                        address: jobPost.address ?? 'Cập nhật sau',
                        isPayPerHourJob: isPayPerHourJob,
                        startTime: isPayPerHourJob
                            ? jobPost.payPerHourJob!.startTime
                            : "8:00",
                        endTime: isPayPerHourJob
                            ? jobPost.payPerHourJob!.finishTime.toString()
                            : jobPost.payPerTaskJob!.finishTime.toString() ==
                                    'null'
                                ? "17:00"
                                : jobPost.payPerTaskJob!.finishTime.toString(),                       
                        moreDetail: () {
                          Get.toNamed(Routes.farmerInprogressJobDetail,
                              arguments: {Arguments.item: jobPost});
                        }));
              }));
        }));
  }

 

}
