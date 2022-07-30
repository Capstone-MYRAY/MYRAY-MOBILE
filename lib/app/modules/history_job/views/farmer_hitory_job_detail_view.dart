import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/history_job/controllers/farmer_history_job_controller.dart';
import 'package:myray_mobile/app/modules/history_job/widgets/farmer_history_detail/information_work_card.dart';
import 'package:myray_mobile/app/modules/history_job/widgets/farmer_history_detail/landowner_cart.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class FarmerHistoryJobDetail extends GetView<FarmerHistoryJobController> {
  const FarmerHistoryJobDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.labelHistoryJobDetail),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Icon(
                Icons.work_history_rounded,
                size: 45,
                color: AppColors.brown.withOpacity(0.7),
              ),
              Container(
                width: Get.width * 0.7,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.grey.withOpacity(0.5)),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Tên công việc',
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.headline6!.copyWith(
                    color: AppColors.brown,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const LandOwnerCard(
                name: 'Tên chủ rẫy',
                address:
                    '4 Hẻm 66/47 Hiệp Thành 45, Hiệp Thành, Quận 12, Hồ Chí Minh',
              ),
              const SizedBox(
                height: 20,
              ),
              InformationWorkCard(
                startDate: DateTime.now(),
                permitedNumDayOff: 2,
                notPermitedNumDayOff: 0,
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(
                  color: AppColors.grey.withOpacity(0.5),
                  indent: 45,
                  endIndent: 45),
               const SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width * 0.6,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * 0.03,
                      child: Text(
                        'Báo cáo trả công ',
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.headline4!.copyWith(
                          color: AppColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
               const SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width * 0.75,
                height: 300,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.grey.withOpacity(0.4),
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 100,
                    itemBuilder: ((context, index) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.white,
                        ),
                        child: Text('01/01/1997'),
                      );
                    })),
              ),
               const SizedBox(
                height: 15,
              ),
              Container(
                width: Get.width * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng tiền:',
                      style: Get.textTheme.bodyText1!.copyWith(
                          color: Colors.transparent,
                          fontSize: 20,
                          shadows: const [
                            Shadow(
                                color: AppColors.primaryColor,
                                offset: Offset(0, -5))
                          ],
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor,
                          decorationThickness: 1),
                    ),
                    Text(Utils.vietnameseCurrencyFormat.format(5000000),
                        style: Get.textTheme.bodyText1!.copyWith(
                          fontSize: 18,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
