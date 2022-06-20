import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_home_controller.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_post_card.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';

class FarmerHomeView extends GetView<FarmerHomeController> {
  const FarmerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.home),
          centerTitle: true,
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: controller.listJobPost.length,
            itemBuilder: (context, index) {
              if (controller.listJobPost[index].payPerHourJob != null) {
                return Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: FarmerPostCard(
                    title: controller.listJobPost[index].title,
                    address: "142 Lâm Đồng",
                    price: 30000,
                    treeType: "Cây cà phê",
                    workType: "Làm công",
                    isStatus: true,
                    onTap: () {
                      print("Tap job post");
                    },
                  ),
                );
              } else if (controller.listJobPost[index].payPerTaskJob != null) {
                return Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: FarmerPostCard(
                    title: controller.listJobPost[index].title,
                    address: "142 Lâm Đồng",
                    price: 30000,
                    treeType: "Cây cà phê",
                    workType: "Làm khoán",
                    isStatus: true,
                    onTap: () {
                      print("Tap job post");
                    },
                  ),
                );
              } else {
                return Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: FarmerPostCard(
                    title: controller.listJobPost[index].title,
                    address: "142 Lâm Đồng",
                    price: 30000,
                    treeType: "Cây cà phê",
                    isStatus: true,
                    onTap: () {
                      print("Tap job post");
                    },
                  ),
                );
              }
            },
          ),
        ));
  }
}
