import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';

class AppliedJobView extends StatelessWidget {
  const AppliedJobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.applied),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AppliedJobView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
