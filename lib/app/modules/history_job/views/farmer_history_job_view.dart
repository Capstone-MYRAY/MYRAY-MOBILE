import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/history_job/controllers/farmer_history_job_controller.dart';
import 'package:myray_mobile/app/modules/history_job/widgets/history_job_card.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class FarmerHistoryJobView extends GetView<FarmerHistoryJobController> {
  const FarmerHistoryJobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.labelHistoryJob),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: controller.getHistoryJobList(),
          builder: (constext, snapshot) {
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
                  onEndOfPage: controller.getHistoryJobList,
                  onRefresh: controller.onRefresh,
                  isLoading: controller.isLoading.value,
                  itemCount: controller.historyJobPostList.isEmpty
                      ? 1
                      : controller.historyJobPostList.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data == null ||
                        controller.historyJobPostList.isEmpty) {
                      return HistoryJobCard(
                        title: 'Công việc kết thúc',
                        nameOnwner: 'Tên chủ rẫy',
                        type: 'Làm khoán/công',
                        startDate: DateTime.now(),
                        endDate: DateTime.now(),
                        onTap: (){
                          Get.toNamed(Routes.farmerHistoryJobDetail);
                        }
                      );
                    }
                  JobPost jobPost = controller.historyJobPostList[index];
                  return HistoryJobCard(
                        title: jobPost.title,
                        nameOnwner: 'Tên chủ rẫy',
                        type: 'Làm khoán/công',
                        startDate: DateTime.now(),
                        endDate: DateTime.now(),
                        onTap: (){
                          Get.toNamed(Routes.farmerHistoryJobDetail);
                        }
                      );
                  },
                ));
          }),
    );
  }
}
