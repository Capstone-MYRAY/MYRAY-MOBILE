import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';

class FarmerHistoryJobDetail extends StatelessWidget {
  const FarmerHistoryJobDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.labelHistoryJobDetail),
          centerTitle: true,
        ),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: Get.width * 0.6,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                padding: const EdgeInsets.all(20),
                child: Expanded(
                  child: Text(
                    'Tên công việc',
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.headline4!.copyWith(
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )),
            Row(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  color: AppColors.white,
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      width: Get.width * 0.55,
                      child: Text('Thẻ chủ rẫy')),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  color: AppColors.white,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: Get.width * 0.4,
                    child: Column(children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Đánh giá',
                          style: Get.textTheme.headline5!.copyWith(
                              color: Colors.transparent,
                              shadows: const [
                                Shadow(
                                    color: AppColors.primaryColor,
                                    offset: Offset(0, -5))
                              ],
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryColor,
                              decorationThickness: 1),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Báo cáo',
                          style: Get.textTheme.headline5!.copyWith(
                              color: Colors.transparent,
                              shadows: const [
                                Shadow(
                                    color: AppColors.primaryColor,
                                    offset: Offset(0, -5))
                              ],
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryColor,
                              decorationThickness: 1),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              color: AppColors.white,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  width: Get.width * 0.85,
                  child: Text('Thẻ thông tin các ngày quan trọng')),
            ),
            Divider(
                color: AppColors.grey.withOpacity(0.5),
                indent: 25,
                endIndent: 25),
            Container(
                width: Get.width * 0.6,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                padding: const EdgeInsets.all(20),
                child: Expanded(
                  child: Text(
                    'Báo cáo trả công',
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.headline4!.copyWith(
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )),
          ],
        ));
  }
}
