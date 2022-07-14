import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/extend_end_date_job.dart';
import 'package:myray_mobile/app/modules/applied_job/controllers/applied_job_controller.dart';
import 'package:myray_mobile/app/modules/applied_job/widgets/farmer_extend_job/farmer_extend_job_card.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class FarmerExtendJobList extends GetView<AppliedJobController> {
  const FarmerExtendJobList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getExtendEndDateJobList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingBuilder();
        }
        return Obx(() => LazyLoadingList(
              onEndOfPage: controller.getExtendEndDateJobList,
              onRefresh: controller.onRefreshExtendPage,
              itemCount: controller.listObject.isNotEmpty
                  ? controller.listObject.length
                  : 1,
              itemBuilder: (context, index) {
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
                print("snapshot: ${snapshot.data}");
                if (snapshot.data == null || controller.listObject.isEmpty) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.3),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Không có đơn gia hạn nào.",
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
                ExtendEndDateJob appliedJob = controller.listObject[index];
                return FarmerExtendJobCard(
                  title: appliedJob.jobTitle ?? "Công việc hiện tại",
                  startOldDate: appliedJob.oldEndDate,
                  startNewDate: appliedJob.extendEndDate,
                  createdDate: appliedJob.createdDate,
                  status: appliedJob.status,
                  buttonLabel: 'Xin hủy',
                  confirmButtonLeft: appliedJob.status == 0 ? () {print('Cập nhật');} : () {},
                  confirmButtonRight: appliedJob.status == 0 ? () {print('Hủy yêu cầu');} : () {},
                );
              },
            ));
      },
    );
  }
}
