import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/status.dart';
import 'package:myray_mobile/app/modules/attendance/controllers/job_post_attendance_controller.dart';
import 'package:myray_mobile/app/modules/attendance/widgets/check_attendance_card.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:table_calendar/table_calendar.dart';

class JobPostAttendanceView extends GetView<JobPostAttendanceController> {
  const JobPostAttendanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.jobTitle),
      ),
      body: Column(
        children: [
          _buildTableCalendar(),
          const SizedBox(height: 8.0),
          _buildAttendances(),
        ],
      ),
    );
  }

  Widget _buildAttendances() {
    return GetBuilder<JobPostAttendanceController>(
      id: 'Attendances',
      builder: (controller) => FutureBuilder(
          future: controller.loadAttendancesByDate(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                !controller.attendances
                    .containsKey(controller.selectedDate.value)) {
              return const MyLoadingBuilder();
            }

            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.selectedAttendances.length,
                itemBuilder: (_, index) {
                  final item = controller.selectedAttendances[index];
                  final now = DateUtils.dateOnly(DateTime.now());
                  return GetBuilder<JobPostAttendanceController>(
                      id: 'CA-${item.farmer.id}',
                      builder: (_) {
                        bool isFiredOrEnd = item.appliedFarmerStatus ==
                                AppliedFarmerStatus.fired.index ||
                            item.appliedFarmerStatus ==
                                AppliedFarmerStatus.end.index;

                        bool isSelectedBeforeEndDate = false;

                        if (item.endDate != null) {
                          isSelectedBeforeEndDate =
                              controller.selectedDate.value.isBefore(
                                  DateUtils.dateOnly(item.endDate!.toLocal()));
                        }

                        bool isFiredEndDisplay =
                            isFiredOrEnd && isSelectedBeforeEndDate;

                        bool isEmptyDisplay = item.attendance.isEmpty &&
                            (item.appliedFarmerStatus ==
                                    AppliedFarmerStatus.approved.index ||
                                isFiredEndDisplay);

                        bool isNotEmptyDisplay = item.attendance.isNotEmpty &&
                            (item.attendance.first.status ==
                                    AttendanceStatus.present.index ||
                                item.attendance.first.status ==
                                    AttendanceStatus.absent.index ||
                                (item.attendance.first.status ==
                                        AttendanceStatus.dayOff.index &&
                                    item.appliedFarmerStatus ==
                                        AppliedFarmerStatus.approved.index));

                        bool isDisplay = isEmptyDisplay || isNotEmptyDisplay;

                        if (!isDisplay) {
                          return const SizedBox();
                        }

                        bool isControlDisplayed = item.attendance.isEmpty &&
                            !controller.selectedDate.value.isAfter(now);

                        return CheckAttendanceCard(
                          key: ValueKey(
                            '${controller.selectedDate.toString()}-${item.farmer.id}',
                          ),
                          fullName: item.farmer.fullName ?? '',
                          phone: item.farmer.phoneNumber ?? '',
                          avatar: item.farmer.imageUrl,
                          isFiredOrEnd: isFiredOrEnd,
                          isControlDisplayed: isControlDisplayed,
                          statusName: item.attendance.isNotEmpty
                              ? item.attendance.first.statusString
                              : AppStrings.noAttendance,
                          statusBackground: item.attendance.isNotEmpty
                              ? item.attendance.first.statusColor
                              : AppColors.grey,
                          reason: item.attendance.isNotEmpty
                              ? item.attendance.first.reason
                              : null,
                          onPresent: () => controller.onPresent(item.farmer),
                          onAbsent: () => controller.onAbsent(item.farmer),
                          onFired: () => controller.onFired(item.farmer),
                        );
                      });
                },
              ),
            );
          }),
    );
  }

  Widget _buildTableCalendar() {
    return Obx(
      () => TableCalendar(
        locale: 'vi_VN',
        firstDay: controller.startDate,
        lastDay: controller.endDate!,
        focusedDay: controller.selectedDate.value,
        calendarFormat: CalendarFormat.week,
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        rangeSelectionMode: RangeSelectionMode.disabled,
        onDaySelected: controller.onDaySelected,
        selectedDayPredicate: (day) {
          return Utils.isTheSameDate(day, controller.selectedDate.value);
        },
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, date, focusedDate) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              child: Text(
                date.day.toString().padLeft(2, '0'),
                style: Get.textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          },
          disabledBuilder: (context, date, focusedDate) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              child: Text(
                date.day.toString().padLeft(2, '0'),
                style: Get.textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Get.theme.disabledColor,
                ),
              ),
            );
          },
          selectedBuilder: (context, date, events) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                borderRadius:
                    BorderRadius.circular(CommonConstants.borderRadius),
              ),
              child: Text(
                date.day.toString().padLeft(2, '0'),
                style: Get.textTheme.headline6!.copyWith(
                  color: AppColors.white,
                ),
              ),
            );
          },
          todayBuilder: (context, date, events) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              child: Text(
                date.day.toString().padLeft(2, '0'),
                style: Get.textTheme.headline6,
              ),
            );
          },
          headerTitleBuilder: (context, date) {
            return Align(
              alignment: Alignment.center,
              child: Text(
                'Tháng ${date.month} năm ${date.year}',
                style: Get.textTheme.bodyText1,
              ),
            );
          },
          dowBuilder: (context, date) {
            return Align(
              alignment: Alignment.center,
              child: Text(
                Utils.getWeekdayStr(date),
                style: Get.textTheme.bodyText2,
              ),
            );
          },
        ),
      ),
    );
  }
}
