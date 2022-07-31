import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/applied_farmer_controller.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/extend_job_controller.dart';

class WaitingApproveTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> tabs = const [
    Tab(
      text: 'Công việc',
    ),
    Tab(
      text: 'Gia hạn',
    ),
  ];

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    Get.put(AppliedFarmerController());
    Get.put(ExtendJobController());
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
