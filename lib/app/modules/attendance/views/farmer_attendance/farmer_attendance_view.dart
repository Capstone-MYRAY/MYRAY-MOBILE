import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/attendance/controllers/farmer_attendance_controller.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_inprogress_job_controller.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/cards/feature_option.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class FarmerAttendanceView extends StatelessWidget {
  const FarmerAttendanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(AppStrings.titleCheckattendance),
            centerTitle: true),
        body: GetBuilder<FarmerAttendanceController>(
          builder: (controller) {
            return FutureBuilder(
                future: controller.getPayPerHourJobList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const MyLoadingBuilder();
                  }
                  return Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.02,
                              horizontal: Get.width * 0.05,
                            ),
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Danh sách công việc',
                              style: Get.textTheme.headline3!
                                  .copyWith(color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                      Obx(() => Padding(
                            padding: const EdgeInsets.only(top: 100.0),
                            child: LazyLoadingList(
                              onEndOfPage: controller.getPayPerHourJobList,
                              onRefresh: controller.onRefresh,
                              itemCount: controller.payPerHourJobList.isEmpty
                                  ? 1
                                  : controller.payPerHourJobList.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data == null ||
                                    controller.payPerHourJobList.isEmpty) {
                                  return Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Không có công việc nào",
                                          style:
                                              Get.textTheme.bodyLarge!.copyWith(
                                            color: AppColors.grey,
                                            fontSize: Get.textScaleFactor * 20,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const ImageIcon(
                                            AssetImage(AppAssets.noJobFound),
                                            size: 30,
                                            color: AppColors.grey),
                                      ],
                                    ),
                                  );
                                }
                                JobPost jobPost =
                                    controller.payPerHourJobList[index].jobPost;
                                return jobPost.type == 'PayPerHourJob'
                                    ? FeatureOption(
                                        icon: Icons.cases_outlined,
                                        title: jobPost.title,
                                        onTap: () {
                                          controller.currentJobPost = jobPost;
                                          Get.toNamed(
                                              Routes.farmerAttendanceWorkDay);
                                        },
                                      )
                                    : const SizedBox();
                              },
                            ),
                          )),
                    ],
                  );
                });
          },
        ));
  }
}
