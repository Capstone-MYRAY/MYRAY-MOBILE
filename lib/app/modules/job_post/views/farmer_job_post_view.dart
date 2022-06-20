import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';

class FarmerJobPostView extends StatelessWidget {
  const FarmerJobPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.jobPost),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Text("hello"),
          ],
        ));
  }
}
