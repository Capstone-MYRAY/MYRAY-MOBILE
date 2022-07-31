import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/home/widgets/landowner_current_job/landowner_current_start_jobs_section.dart';
import 'package:myray_mobile/app/modules/home/widgets/landowner_main_feature/landowner_feature_functions.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/landowner_appbar.dart';

import '../controllers/landowner_home_controller.dart';

class LandownerHomeView extends GetView<LandownerHomeController> {
  const LandownerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LandownerAppbar(
        title: Text(
          AppStrings.home,
          textScaleFactor: 1,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: RefreshIndicator(
          onRefresh: () async {
            controller.refreshCurrentStartJob();
          },
          child: ListView(
            shrinkWrap: true,
            children: const [
              LandownerFeatureFunctions(),
              LandownerCurrentStartJobsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
