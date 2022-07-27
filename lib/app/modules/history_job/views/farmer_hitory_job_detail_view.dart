import 'package:flutter/material.dart';
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
      body: const Center(
        child: Text('Chi tiết công việc')
      ),
    );
  }
}