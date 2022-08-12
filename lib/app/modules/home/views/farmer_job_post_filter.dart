import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/filter_object.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_home_controller.dart';
import 'package:myray_mobile/app/modules/home/widgets/farmer_filter.dart/work_type_field.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/widgets/filters/filter_section.dart';
import 'package:myray_mobile/app/shared/widgets/filters/inline_filter.dart';

class FarmerJobPostFilter extends GetView<FarmerHomeController> {
  FarmerJobPostFilter({Key? key}) : super(key: key);
  final paidTypeKey = GlobalKey<InlineFilterState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bộ lọc'),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: ListView(children: [
            _buildPaidTypeFilter(),
            FilterSection(
                title: 'Loại công việc',
                child: WorkTypeField(
                  workTypes: controller.workTypeResponse != null ? controller.workTypeResponse!.workTypes : [],
                  selectedWorkTypes: controller.selectedWorkTypes,
                ))
          ]),
        ),
      ]),
    );
  }

  Widget _buildPaidTypeFilter() {
    return FilterSection(
      title: AppStrings.labelWorkPayType,
      child: InlineFilter(
        key: paidTypeKey,
        onChanged: (value) {
          controller.paidTypeFilter = value;
          print('Selected paid type: $value');
        },
        selectedItem: controller.paidTypeFilter,
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
