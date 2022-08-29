import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance_response.dart';
import 'package:myray_mobile/app/modules/attendance/controllers/farmer_attendance_controller.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class FarmerWorkDayView extends StatelessWidget {
  const FarmerWorkDayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text('Các ngày làm việc'), centerTitle: true),
        body: GetBuilder<FarmerAttendanceController>(
          builder: (controller) {
            return FutureBuilder(
                future: controller.getAttendanceByJob(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: MyLoadingBuilder(),
                    );
                  }
                  return Stack(
                    children: [
                      Obx(() => LazyLoadingList(
                            onEndOfPage: controller.getAttendanceByJob,
                            onRefresh: controller.onRefreshAttendanceList,
                            itemCount: controller.attendances.isEmpty
                                ? 1
                                : controller.attendances.length,
                            itemBuilder: (context, index) {
                              if (controller.attendances.isEmpty) {
                                return Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Chưa có ngày điểm danh nào",
                                        style:
                                            Get.textTheme.bodyLarge!.copyWith(
                                          color: AppColors.grey,
                                          fontSize: Get.textScaleFactor * 20,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Icon(
                                        Icons.pending_actions_outlined,
                                        color: AppColors.grey,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              AttendanceResponse attendance =
                                  controller.attendances[index];
                              return InkWell(
                                onTap: () {
                                  controller.showAttendance(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.only(top: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        Utils.formatddMMyyyy(attendance.date),
                                        style: Get.textTheme.labelMedium!
                                            .copyWith(
                                                fontSize:
                                                    Get.textScaleFactor * 15),
                                      ),
                                      Text(
                                        attendance.statusString,
                                        style: TextStyle(
                                            color: attendance.statusColor,
                                            fontStyle: FontStyle.italic),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
                    ],
                  );
                });
          },
        ));
  }
}
