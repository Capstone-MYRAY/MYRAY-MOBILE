import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/extend_end_date_job.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/extend_job_controller.dart';
import 'package:myray_mobile/app/modules/applied_farmer/widgets/extend_job_request_card.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class ExtendJobList extends StatelessWidget {
  const ExtendJobList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExtendJobController>(
      builder: (controller) => FutureBuilder(
        future: controller.getExtendRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBuilder();
          }

          if (snapshot.data == null) {
            return ListEmptyBuilder(onRefresh: controller.onRefresh);
          }

          if (snapshot.hasData) {
            return Obx(
              () => LazyLoadingList(
                onEndOfPage: controller.getExtendRequests,
                isLoading: controller.isLoading.value,
                onRefresh: controller.onRefresh,
                itemCount: controller.extendRequests.length,
                itemBuilder: ((context, index) {
                  ExtendEndDateJob request = controller.extendRequests[index];
                  return ExtendJobRequestCard(
                    key: ValueKey(request.id),
                    extendRequest: request,
                    onApprove: () => controller.onApprove(request),
                    onReject: () => controller.onReject(request),
                  );
                }),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
