import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_job_post_controller.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_job_list.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';

class FarmerJobPostView extends GetView<FarmerJobPostController> {
  const FarmerJobPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: const Text(AppStrings.jobPost),
          ),
          centerTitle: true,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: controller.tabBar.preferredSize,
            child: Material(
              color: AppColors.backgroundColor,
              // child: Container(
              //   padding: EdgeInsets.only(left: 10),
              //   decoration: BoxDecoration(
              //     color: Colors.amberAccent,
              //     shape: BoxShape.rectangle,
              //   ),
              //   child: controller.tabBar
              // ),
                child: controller.tabBar

               
            ),
          )
        ),
        body: TabBarView(
          children: <Widget>[
            const FarmerInprogressJobList(),
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
      ),
    );
  }
}
