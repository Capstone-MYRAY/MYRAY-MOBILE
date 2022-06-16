import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/landowner_appbar.dart';

class AppliedFarmerView extends StatelessWidget {
  const AppliedFarmerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: LandownerAppbar(
        title: Text(
          AppStrings.applied,
          textScaleFactor: 1,
        ),
      ),
      body: Center(
        child: Text(
          'AppliedFarmerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
