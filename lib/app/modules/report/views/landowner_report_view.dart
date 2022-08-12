import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
import 'package:myray_mobile/app/modules/report/controllers/landowner_report_controller.dart';
import 'package:myray_mobile/app/modules/report/widgets/landowner_report_card.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/controls/dropdown_list.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class LandownerReportView extends GetView<LandownerReportController> {
  const LandownerReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.titleReportList)),
      body: Column(
        children: [
          Obx(
            () => DropdownList(
              items: controller.buildFilterList(),
              onChanged: controller.onChangedFilter,
              value: controller.selectedFilter.value,
            ),
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return GetBuilder<LandownerReportController>(
      builder: (_) => FutureBuilder(
        future: controller.getReports(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyLoadingBuilder();
          }

          if (snapshot.data == null) {
            return ListEmptyBuilder(
              onRefresh: controller.onRefresh,
              msg: AppMsg.MSG4039,
            );
          }

          if (snapshot.hasData) {
            return Obx(
              () => LazyLoadingList(
                onEndOfPage: controller.getReports,
                isLoading: controller.isLoading.value,
                onRefresh: controller.onRefresh,
                itemCount: controller.reports.length,
                itemBuilder: ((context, index) {
                  Report report = controller.reports[index];
                  return LandownerReportCard(
                    key: ValueKey(report.id),
                    createdDate: report.createdDate,
                    phone: report.reportedPhone ?? '',
                    avatar: report.reportedAvatar,
                    fullName: report.reportedName ?? '',
                    workName: report.jobPostTitle ?? '',
                    statusName: report.statusString,
                    statusColor: report.statusColor,
                    onButtonTap: () {
                      Get.toNamed(
                        Routes.landownerReportDetails,
                        arguments: {
                          Arguments.tag: report.id.toString(),
                          Arguments.item: report,
                        },
                      );
                    },
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
