import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
import 'package:myray_mobile/app/modules/report/controllers/landowner_report_details_controller.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_user_info.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_status_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';

class LandownerReportDetailsView
    extends GetView<LandownerReportDetailsController> {
  const LandownerReportDetailsView({Key? key}) : super(key: key);

  @override
  String? get tag => Get.arguments[Arguments.tag];

  Report get report => controller.report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleReportDetails),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyCard(
                child: Column(
                  children: [
                    Text(
                      'Thông tin người bị báo cáo',
                      style: Get.textTheme.headline6,
                    ),
                    const SizedBox(height: 8.0),
                    CardUserInfo(
                      phone: 'wait for Lâm',
                      fullName: report.reportedName ?? '',
                      radius: 36.0,
                      avatar: null,
                    ),
                  ],
                ),
              ),
              _buildReportInfo(),
              if (report.resolvedName != null) _buildResolvedInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportInfo() {
    return MyCard(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Thông tin báo cáo',
              style: Get.textTheme.headline6,
            ),
          ),
          const SizedBox(height: 16.0),
          CardField(
            icon: CustomIcons.briefcase_outline,
            title: AppStrings.labelWorkName,
            data: 'wait for Lam',
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.calendar_range,
            title: AppStrings.labelCreatedDate,
            data: Utils.formatddMMyyyy(report.createdDate),
            isCenter: true,
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.content_paste,
            title: AppStrings.labelReportDescription,
            data: report.content,
          ),
          const SizedBox(height: 8.0),
          CardStatusField(
            title: 'Trạng thái',
            statusName: report.statusString ?? '',
            backgroundColor: report.statusColor,
          ),
        ],
      ),
    );
  }

  Widget _buildResolvedInfo() {
    return MyCard(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Thông tin giải quyết',
              style: Get.textTheme.headline6,
            ),
          ),
          const SizedBox(height: 16.0),
          CardField(
            icon: CustomIcons.account_outline,
            title: AppStrings.labelResolvedBy,
            data: report.resolvedName!,
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.calendar_range,
            title: AppStrings.labelResolvedDate,
            data: Utils.formatddMMyyyy(report.resolvedDate!),
            isCenter: true,
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.content_paste,
            title: AppStrings.labelResolvedContent,
            data: report.resolveContent!,
          ),
        ],
      ),
    );
  }
}
