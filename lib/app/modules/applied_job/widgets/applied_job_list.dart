import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_response.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/applied_job/controllers/applied_job_controller.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';

class AppliedJobList extends GetView<AppliedJobController> {
  const AppliedJobList({Key? key}) : super(key: key);
//future buider
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetAppliedJobPostList?>(
      future: controller.getAppliedJobList(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingBuilder();
        }
        if (snapshot.hasError || snapshot.data == null) {
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

        if (snapshot.hasData) {
          controller.appliedJobList = snapshot.data!.obs;
          return ListView.builder(
              itemCount: controller.appliedJobList!.value.listObject!.length,
              itemBuilder: (((context, index) {
                JobPost jobPost =
                    controller.appliedJobList!.value.listObject![index].jobPost;
                return Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Card(
                        color: AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(jobPost.title,
                                        style:
                                            Get.textTheme.headline3?.copyWith(
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 15, right: 15),
                              child: Row(
                                children: [
                                  const Icon(CustomIcons.map_marker_outline,
                                      size: 20),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      jobPost.address,
                                      style: Get.textTheme.bodyText2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      maxLines: 10,
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
                                  const Icon(CustomIcons.calendar_star,
                                      size: 20),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Row(children: [
                                      Text(
                                        "Ngày bắt đầu:",
                                        style: Get.textTheme.labelMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        DateFormat('dd-MM-yyyy').format(
                                            controller
                                                .appliedJobList!
                                                .value
                                                .listObject![index]
                                                .appliedDate),
                                        style:
                                            Get.textTheme.bodyText2!.copyWith(
                                          color: AppColors.primaryColor,
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
                                  const Icon(CustomIcons.box,
                                      size: 20),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Row(children: [
                                      Text(
                                        "Loại hình công việc: ",
                                        style: Get.textTheme.labelMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        controller
                                                    .appliedJobList!
                                                    .value
                                                    .listObject![index]
                                                    .jobPost
                                                    .type ==
                                                "PayPerHourJob"
                                            ? AppStrings.payPerHour
                                            : AppStrings.payPerTask,
                                        style:
                                            Get.textTheme.bodyText2!.copyWith(
                                          color: AppColors.primaryColor,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 45, vertical: 8),
                              onPressed: () {},
                              title: AppStrings.cancel,
                              border: Border.all(
                                color: AppColors.primaryColor,
                              ),
                              foreground: AppColors.primaryColor,
                              background: AppColors.white,
                            ),
                          ]),
                        )));
              })));
        }
        return const SizedBox();
      }),
    );
  }
}
