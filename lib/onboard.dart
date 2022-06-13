import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed(Routes.landownerDashboard);
              },
              child: const Text('Landowner'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed(Routes.farmerDashboard);
              },
              child: const Text('Farmer'),
            ),
          ],
        ),
      ),
    );
  }
}
