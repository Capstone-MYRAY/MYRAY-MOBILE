import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/extend_end_date_job.dart';
import 'package:myray_mobile/app/modules/applied_job/controllers/applied_job_controller.dart';
import 'package:myray_mobile/app/modules/applied_job/widgets/farmer_extend_job/farmer_extend_job_card.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_form_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class FarmerExtendJobList extends GetView<AppliedJobController> {
  const FarmerExtendJobList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getExtendEndDateJobList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingBuilder();
        }
        return Obx(() => LazyLoadingList(
              onEndOfPage: controller.getExtendEndDateJobList,
              onRefresh: controller.onRefreshExtendPage,
              itemCount: controller.listObject.isNotEmpty
                  ? controller.listObject.length
                  : 1,
              itemBuilder: (context, index) {
                if (snapshot.hasError) {
                  printError(info: snapshot.error.toString());
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error,
                          size: 50.0,
                          color: AppColors.errorColor,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Đã có lỗi xảy ra',
                          style: Get.textTheme.headline6!.copyWith(
                            color: AppColors.errorColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                print("snapshot: ${snapshot.data}");
                if (snapshot.data == null || controller.listObject.isEmpty) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.3),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Không có đơn gia hạn nào.",
                            style: Get.textTheme.bodyLarge!.copyWith(
                              color: AppColors.grey,
                              fontSize: Get.textScaleFactor * 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const ImageIcon(AssetImage(AppAssets.noJobFound),
                              size: 30, color: AppColors.grey),
                        ],
                      ),
                    ),
                  );
                }
                ExtendEndDateJob appliedJob = controller.listObject[index];
                return FarmerExtendJobCard(
                  title: appliedJob.jobTitle ?? "Công việc hiện tại",
                  startOldDate: appliedJob.oldEndDate,
                  startNewDate: appliedJob.extendEndDate,
                  createdDate: appliedJob.createdDate ?? DateTime.now(),//ko tra ve ngay tao khi update xong
                  status: appliedJob.status,
                  buttonLabel: 'Xin hủy',
                  confirmButtonLeft: appliedJob.status == 0 ? () => {_showExtendJobDialog(appliedJob)} : () {},
                  confirmButtonRight: appliedJob.status == 0 ? () {controller.canceExtendEndDate(appliedJob.id);} : () {},
                  message: 'Bạn muốn hủy yêu cầu gia hạn ngày kết thúc của công việc này ?',
                );
              },
            ));
      },
    );
  }

    Future _showExtendJobDialog(ExtendEndDateJob appliedJob) async {
    controller.onInitUpdateExtendEndDateForm(appliedJob);
    return CustomFormDialog.showDialog(
      formKey: controller.formKey,
      title: 'Gia hạn ngày kết thúc',
      textFields: [
        InputField(
          key: UniqueKey(),
          controller: controller.extendEndDateController,
          icon: const Icon(Icons.edit_calendar_outlined),
          labelText: 'Ngày gia hạn*',
          placeholder: AppStrings.placeholderNewExtendJobDate,
          inputAction: TextInputAction.next,
          readOnly: true,
          onTap: () => {controller.onChooseNewEndDate(appliedJob.oldEndDate)},
        ),
        SizedBox(
          height: Get.height * 0.04,
        ),
        InputField(
          key: UniqueKey(),
          controller: controller.reasonExtendEndDateController,
          icon: const Icon(Icons.announcement_outlined),
          labelText: AppStrings.titleReason,
          placeholder: AppStrings.placeholderReport,
          keyBoardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 10,
          validator: controller.validateReason,
        ),
      ],
      onSubmit: () => {controller.onSubmitExtendJobForm(appliedJob)},
      onCancel: controller.onCloseExtendJobDialog,
    );
  }
}
