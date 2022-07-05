import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/landowner_job_post_details/toggle_content_work_info.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/landowner_job_post_details/toggle_information.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';

class LandownerJobPostDetailsView extends GetView<LandownerJobPostDetailsView> {
  const LandownerJobPostDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        children: [
          ToggleInformation(
            tagName: 'WorkInformation',
            title: AppStrings.titleWorkInformation,
            child: ToggleContentWorkInfo(),
          ),
        ],
      ),
    );
  }
}
