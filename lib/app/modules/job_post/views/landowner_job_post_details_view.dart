import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/landowner_job_post_details/toggle_information.dart';

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
          ),
          ToggleInformation(
            tagName: 'WorkPlaceInformation',
          ),
          ToggleInformation(
            tagName: 'PostInformation',
          ),
          ToggleInformation(
            tagName: 'PaymentInformation',
          ),
        ],
      ),
    );
  }
}
