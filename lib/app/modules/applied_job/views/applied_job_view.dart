import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/applied_job/controllers/applied_job_controller.dart';
import 'package:myray_mobile/app/modules/applied_job/widgets/applied_job_list.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';

class AppliedJobView extends GetView<AppliedJobController> {
  const AppliedJobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.applied),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Container(
            padding: const EdgeInsets.only(top: 5),
            height: Get.height,
            child: Column(children: [
              Container(
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: controller.tabBar,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                indent: 10,
                endIndent: 10,
                color: AppColors.brown,
                thickness: 0.5,
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: <Widget>[
                    AppliedJobList(),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            AppStrings.noMarkedJobPost,
                            style: Get.textTheme.bodyMedium!
                                .copyWith(color: AppColors.grey),
                          ),
                          const SizedBox(height: 10),
                          const ImageIcon(AssetImage(AppAssets.noJobFound),
                              size: 20, color: AppColors.grey),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            AppStrings.noMarkedJobPost,
                            style: Get.textTheme.bodyMedium!
                                .copyWith(color: AppColors.grey),
                          ),
                          const SizedBox(height: 10),
                          const ImageIcon(AssetImage(AppAssets.noJobFound),
                              size: 20, color: AppColors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
