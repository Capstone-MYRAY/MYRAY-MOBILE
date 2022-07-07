import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/applied_job/controllers/applied_job_controller.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';
import 'package:myray_mobile/app/shared/widgets/custom_confirm_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class AppliedJobList extends GetView<AppliedJobController> {
  const AppliedJobList({Key? key}) : super(key: key);
//future buider
  @override
  Widget build(BuildContext context) {
    return
        // Obx(() => controller.isRefresh.value ? const LoadingBuilder() :
        FutureBuilder(
      future: controller.getAppliedJobList(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingBuilder();
        }
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

        return Obx(() => LazyLoadingList(
            onEndOfPage: controller.getAppliedJobList,
            onRefresh: controller.onRefresh,
            itemCount: controller.appliedJobPostResponse.isEmpty
                ? 1
                : controller.appliedJobPostResponse.length,
            itemBuilder: ((context, index) {
              if (snapshot.data == null ||
                  controller.appliedJobPostResponse.isEmpty) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.3),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Bạn chưa ứng tuyển vào công việc nào.",
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

              print("here");
              JobPost jobPost =
                  controller.appliedJobPostResponse[index].jobPost;
              return Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Card(
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(jobPost.title,
                                      style: Get.textTheme.headline3?.copyWith(
                                        color: AppColors.brown,
                                      ),
                                      softWrap: true,
                                      maxLines: 3,
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),                        
                         Container(
                          padding: const EdgeInsets.only(top: 10, right: 15),
                          child: Stack(
                              children: [
                                const Icon(CustomIcons.map_marker_outline,
                                    size: 20),
                                Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: SizedBox(
                                    width: Get.width * 0.65,
                                    child: Text.rich(
                                      TextSpan(
                                        text: jobPost.address ?? '',
                                      ),
                                      style: Get.textTheme.bodyText2!.copyWith(
                                          fontSize: Get.textScaleFactor * 14),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,
                                      maxLines: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                         ),

                          // const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 15, right: 15),
                            child: Row(
                              children: [
                                const Icon(CustomIcons.calendar_star, size: 20),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Row(children: [
                                    Text(
                                      "Ngày bắt đầu:",
                                      style:
                                          Get.textTheme.labelMedium!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: Get.textScaleFactor * 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 52,
                                    ),
                                    Text(
                                      DateFormat('dd-MM-yyyy').format(controller
                                          .appliedJobPostResponse[index]
                                          .appliedDate),
                                      style: Get.textTheme.bodyText2!.copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: Get.textScaleFactor * 15,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      maxLines: 10,
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 15, right: 15),
                            child: Row(
                              children: [
                                const Icon(CustomIcons.box, size: 20),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Row(children: [
                                    Text(
                                      "Loại hình công việc: ",
                                      style:
                                          Get.textTheme.labelMedium!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: Get.textScaleFactor * 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      controller.appliedJobPostResponse[index]
                                                  .jobPost.type ==
                                              "PayPerHourJob"
                                          ? AppStrings.payPerHour
                                          : AppStrings.payPerTask,
                                      style: Get.textTheme.bodyText2!.copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: Get.textScaleFactor * 15,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      maxLines: 10,
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          CustomTextButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 45, vertical: 8),
                            onPressed: () {
                              CustomDialog.show(
                                  confirm: () =>
                                      controller.cancelAppliedJob(jobPost.id),
                                  message:
                                      "Bạn muốn hủy yêu cầu ứng tuyển \n Lưu ý: sau khi hủy, bạn không được phép ứng tuyển lạ!");
                            },
                            title: AppStrings.cancel,
                            border: Border.all(
                              color: AppColors.primaryColor,
                            ),
                            foreground: AppColors.primaryColor,
                            background: AppColors.white,
                          ),
                        ]),
                      )));
              // return SizedBox();
            })));

        // return const SizedBox();
      }),
      // )
    );
    // );
    // );
  }
}
