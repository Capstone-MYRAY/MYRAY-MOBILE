import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_not_start_job/farmer_not_start_job_card.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class FarmerNotStartJobList extends StatelessWidget {
  const FarmerNotStartJobList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 1,
      itemBuilder: ((context, index) {
        return FarmerNotStartJobCard(
          title: "Thu hoạch cà phê",
          address: "144 Dương Đình Hội, lô 17-D11, phường Phước Long B, thành phố Thủ Đức, thành phố Hồ Chí Minh",
          startDate: Utils.fromddMMyyyy("07/07/2022"),
          buttonLabel: 'Xin hủy',
          confirm: (){
            print("Xác nhận hủy");
            Get.back();
          },
        );
      }),);
  }
}