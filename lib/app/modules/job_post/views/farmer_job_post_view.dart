import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_job_post_controller.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_job_list.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_not_start_job/farmer_not_start_job_list.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';

class FarmerJobPostView extends GetView<FarmerJobPostController> {
  const FarmerJobPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: const Text(AppStrings.jobPost),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Container(
          padding: const EdgeInsets.only(top: 5),
          height: Get.height,
          child: Column(
            children: [
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
                indent:10,
                endIndent:10,
                color: AppColors.brown,
                thickness: 0.5,
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: const <Widget>[
                    FarmerInprogressJobList(),
                    Center(
                      child: FarmerNotStartJobList(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
