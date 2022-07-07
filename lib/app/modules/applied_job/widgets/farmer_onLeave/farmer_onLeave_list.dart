import 'package:flutter/material.dart';
import 'package:myray_mobile/app/modules/applied_job/widgets/farmer_onLeave/farmer_onLeave_card.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class FarmerOnLeaveList extends StatelessWidget {
  const FarmerOnLeaveList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 1,
      itemBuilder: (context, index){
        return FarmerOnLeaveCard(
          job: 'Thu hoạch cà phê',
          submitDate: Utils.fromddMMyyyy('07/07/2022'),
          numOfOnleaveDays: 3,
          reason: "Xin nghỉ để chăm bệnh người thân, người thân phải làm phẫu thuật"
        );
      },
    );
  }
}
