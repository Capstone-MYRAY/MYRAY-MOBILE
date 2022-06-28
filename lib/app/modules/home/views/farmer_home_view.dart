import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_home_controller.dart';
import 'package:myray_mobile/app/modules/home/widgets/farmer_post_card.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';

class FarmerHomeView extends GetView<FarmerHomeController> {
  const FarmerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.home),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Text(
                    "Nổi bật",
                    style: Get.textTheme.headline2?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: Get.height * 0.32,
                child: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.listJobPost.length,
                    itemBuilder: (context, index) {                
                      JobPost jobPost = controller.listJobPost[index];
                      var publishedDate = jobPost.publishedDate;
                      var numberPublishDate = jobPost.numPublishDay;
                      var expiredDate = controller.getExpiredDate(publishedDate, numberPublishDate);
                      
                      if (jobPost.payPerHourJob != null) {
                        return FarmerPostCard(
                          title: jobPost.title,
                          address: "142 Lâm Đồng",
                          price: 30000,
                          treeType: "Cây cà phê",
                          workType: "Làm công",
                          isStatus: true,   
                          expiredDate: DateFormat('dd-MM-yyyy').format(expiredDate), 
                          isExpired: controller.checkExpiredDate(expiredDate),                                           
                          onTap: () => {
                            Get.toNamed(Routes.farmerJobPostDetail,
                                arguments: {Arguments.item: jobPost})
                          },
                          
                        );
                      } else {
                        return FarmerPostCard(
                          title: jobPost.title,
                          address: "142 Lâm Đồng",
                          price: 30000,
                          treeType: "Cây cà phê",
                          workType: "Làm khoán",
                          isStatus: true,
                          expiredDate: expiredDate,                                            
                          onTap: () {
                            Get.toNamed(Routes.farmerJobPostDetail,
                                arguments: {Arguments.item: jobPost});
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Text(
                    "Công việc",
                    style: Get.textTheme.headline2?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ]),
              Flexible(
                child: ListView.builder(
                    itemCount: 15,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return FarmerPostCard(
                        title: "Thu hoạch cà phê $index",
                        address: "142 Lâm Đồng",
                        price: 30000,
                        treeType: "Cây cà phê",
                        workType: "Làm công",
                        onTap: () {
                          print("Tap job post");
                        },
                      );
                    }),
              ),
            ]))));
  }
}
