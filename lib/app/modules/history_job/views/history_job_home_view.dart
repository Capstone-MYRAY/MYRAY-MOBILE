

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/card_function.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';

class HistoryJobHomeView extends StatelessWidget {
  const HistoryJobHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử công việc'),
        centerTitle: true,
      ),
      body: Column(
          children: [
            Text('Dash board'),
            Container(
              child: Card(
                child: Text('Đã ứng tuyển'),
              ),
            ),
            // CardFunction(title: 'Đã làm việc', icon: Icons.history, onTap: (){
            //   Get.toNamed(Routes.farmerHistoryJob);
            // }),
          ],
        ),
     
    );
  }
}