import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback_models.dart';
import 'package:myray_mobile/app/modules/feedback/widgets/feedback_bottom_sheet/feedback_empty_builder.dart';
import 'package:myray_mobile/app/modules/feedback/widgets/feedback_bottom_sheet/feedback_list_bottom_sheet_controller.dart';
import 'package:myray_mobile/app/modules/home/widgets/feedback_container.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class FeedbackList extends StatelessWidget {
  final int belongedId;
  const FeedbackList({
    Key? key,
    required this.belongedId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedbackListBottomSheetController>(
      init: FeedbackListBottomSheetController(belongedId: belongedId),
      builder: (controller) => FutureBuilder(
        future: controller.getFeedbacks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyLoadingBuilder();
          }

          if (snapshot.hasError || controller.feedbacks.isEmpty) {
            return FeedbackEmptyBuilder(
              onRefresh: controller.onRefresh,
            );
          }

          return Obx(
            () => LazyLoadingList(
              onEndOfPage: controller.getFeedbacks,
              isLoading: controller.isLoading.value,
              onRefresh: controller.onRefresh,
              itemCount: controller.feedbacks.length,
              itemBuilder: ((context, index) {
                FeedBack feedback = controller.feedbacks[index];
                return FeedBackContainer(feedBack: feedback);
              }),
            ),
          );
        },
      ),
    );
  }
}
