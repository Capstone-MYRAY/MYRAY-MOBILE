import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';

class FarmerJobPostController extends GetxController
    with GetSingleTickerProviderStateMixin {
      
  TabBar get tabBar => TabBar(
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.primaryColor,
          indicatorPadding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          tabs: const <Widget>[
            Tab(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  AppStrings.labelInprogress,
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Tab(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  AppStrings.labelNotStartJob,
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]);

  @override
  void onInit() {
    super.onInit();
  }
}
