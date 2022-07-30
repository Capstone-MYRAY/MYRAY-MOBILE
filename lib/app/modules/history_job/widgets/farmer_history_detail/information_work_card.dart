import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class InformationWorkCard extends StatelessWidget {
  final DateTime startDate;
  final DateTime? endDate;
  final int permitedNumDayOff; //có phép, không phép
  final int notPermitedNumDayOff; //có phép, không phép
  const InformationWorkCard(
      {Key? key,
      required this.startDate,
      required this.permitedNumDayOff,
      required this.notPermitedNumDayOff,
      this.endDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      color: AppColors.white,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: Get.width * 0.7,
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            _buildRowInfor(
                title: 'Ngày bắt đầu:',
                content: Utils.formatddMMyyyy(DateTime.now()),
                icon: CustomIcons.calendar_star,
                spaceTitleAndContent: 18),
            SizedBox(
              height: Get.height * 0.02,
            ),
            _buildRowInfor(
              title: 'Ngày kết thúc:',
              content: Utils.formatddMMyyyy(DateTime.now()),
              icon: CustomIcons.calendar_check,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            _buildRowInfor(
                title: 'Số ngày nghỉ:',
                content: '',
                icon: CustomIcons.calendar_minus,
                spaceTitleAndContent: 20),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Có phép: ',
                        style: Get.textTheme.bodyText2!.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                      Text(
                        '$permitedNumDayOff ngày',
                        style: Get.textTheme.bodyText2!.copyWith(
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    children: [
                      Text(
                        'Không phép: ',
                        style: Get.textTheme.bodyText2!.copyWith(
                          color: AppColors.errorColor,
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                      Text(
                        '$notPermitedNumDayOff ngày',
                        style: Get.textTheme.bodyText2!.copyWith(
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowInfor({
    required String title,
    required String content,
    required IconData icon,
    double? spaceTitleAndContent = 15,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: Get.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: spaceTitleAndContent,
        ),
        SizedBox(
          width: 80,
          child: Text(
            content,
            style: Get.textTheme.bodyText2!.copyWith(
              fontSize: Get.textScaleFactor * 15,
            ),
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
