import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_extend_job/farmer_extend_job_card.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class FarmerExtendJobList extends StatelessWidget {
  const FarmerExtendJobList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: 1,
      itemBuilder: ((context, index) {
        return FarmerExtendJobCard(
          title: "Thu hoạch cà phê",
          address: "144 Dương Đình Hội, lô 17-D11, phường Phước Long B, thành phố Thủ Đức, thành phố Hồ Chí Minh",
          startOldDate: Utils.fromddMMyyyy("07/07/2022"),
          startNewDate: Utils.fromddMMyyyy("08/07/2022"),
          buttonLabel: 'Xin hủy',
          confirm: (){
            print("Xác nhận hủy");
            Get.back();
          },
        );
      }),);
  }
}