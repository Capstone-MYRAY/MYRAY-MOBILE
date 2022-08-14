import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/filter_object.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/filters/filter_controls.dart';
import 'package:myray_mobile/app/shared/widgets/filters/filter_section.dart';
import 'package:myray_mobile/app/shared/widgets/filters/inline_filter.dart';
import 'package:myray_mobile/app/shared/widgets/filters/outlined_filter.dart';

class JobPostFilter extends GetView<LandownerJobPostController> {
  JobPostFilter({
    Key? key,
  }) : super(key: key);

  final workTypeKey = GlobalKey<InlineFilterState>();
  final postTypeKey = GlobalKey<OutlinedFilterState>();
  final postStatusKey = GlobalKey<OutlinedFilterState>();
  final workStatusKey = GlobalKey<OutlinedFilterState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleFilter),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildWorkTypeFilter(),
                _buildPostTypeFilter(),
                _buildPostStatusFilter(),
                _buildWorkStatusFilter(),
              ],
            ),
          ),
          FilterControls(
            onApply: controller.onApplyFilter,
            onClear: () {
              workTypeKey.currentState?.clearFilter();
              postTypeKey.currentState?.clearFilter();
              postStatusKey.currentState?.clearFilter();
              workStatusKey.currentState?.clearFilter();
              controller.onClearFilter();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWorkStatusFilter() {
    return FilterSection(
      title: AppStrings.labelWorkStatus,
      child: OutlinedFilter(
        key: workStatusKey,
        onChanged: (value) => controller.workStatusFilter = value,
        selectedItem: controller.workStatusFilter,
        items: [
          FilterObject(
            name: 'Tất cả',
            value: null,
          ),
          FilterObject(
            name: AppStrings.jobPostWorkStatusPending,
            value: JobPostWorkStatus.pending.index,
          ),
          FilterObject(
            name: AppStrings.jobPostWorkStatusStarted,
            value: JobPostWorkStatus.started.index,
          ),
          FilterObject(
            name: AppStrings.jobPostWorkStatusDone,
            value: JobPostWorkStatus.done.index,
          ),
        ],
      ),
    );
  }

  Widget _buildPostStatusFilter() {
    return FilterSection(
      title: AppStrings.labelPostStatus,
      child: OutlinedFilter(
        key: postStatusKey,
        onChanged: (value) {
          controller.postStatusFilter = value;
        },
        selectedItem: controller.postStatusFilter,
        items: [
          FilterObject(
            name: 'Tất cả',
            value: null,
          ),
          FilterObject(
            name: AppStrings.jobPostStatusPending,
            value: JobPostStatus.pending.index,
          ),
          FilterObject(
            name: AppStrings.jobPostStatusShortHanded,
            value: JobPostStatus.shortHanded.index,
          ),
          FilterObject(
            name: AppStrings.jobPostStatusEnough,
            value: JobPostStatus.enough.index,
          ),
          FilterObject(
            name: AppStrings.jobPostStatusApproved,
            value: JobPostStatus.approved.index,
          ),
          FilterObject(
            name: AppStrings.jobPostStatusEnd,
            value: JobPostStatus.end.index,
          ),
          FilterObject(
            name: AppStrings.jobPostStatusOutOfDate,
            value: JobPostStatus.outOfDate.index,
          ),
          FilterObject(
            name: AppStrings.jobPostStatusRejected,
            value: JobPostStatus.rejected.index,
          ),
          FilterObject(
            name: AppStrings.jobPostStatusCancel,
            value: JobPostStatus.cancel.index,
          ),
        ],
      ),
    );
  }

  Widget _buildPostTypeFilter() {
    return FilterSection(
      title: 'Loại bài đăng',
      child: OutlinedFilter(
        key: postTypeKey,
        items: controller.postTypeList,
        selectedItem: controller.postTypeFilter,
        onChanged: (value) {
          controller.postTypeFilter = value;
          print('Selected post type: $value');
        },
      ),
    );
  }

  Widget _buildWorkTypeFilter() {
    return FilterSection(
      title: AppStrings.labelWorkPayType,
      child: InlineFilter(
        key: workTypeKey,
        onChanged: (value) {
          controller.workTypeFilter = value;
          print('Selected work type: $value');
        },
        selectedItem: controller.workTypeFilter,
        items: [
          FilterObject(
            name: 'Tất cả',
            value: null,
          ),
          FilterObject(
            name: AppStrings.payPerHour,
            value: JobType.payPerHourJob.name,
          ),
          FilterObject(
            name: AppStrings.payPerTask,
            value: JobType.payPerTaskJob.name,
          ),
        ],
      ),
    );
  }
}
