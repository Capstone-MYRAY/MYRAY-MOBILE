import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/landowner_appbar.dart';

import '../controllers/landowner_home_controller.dart';

class LandownerHomeView extends GetView<LandownerHomeController> {
  const LandownerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: LandownerAppbar(
        title: Text(
          AppStrings.home,
          textScaleFactor: 1,
        ),
      ),
      body: Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
