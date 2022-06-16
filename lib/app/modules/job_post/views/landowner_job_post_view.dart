import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/widgets/landowner_appbar.dart';

class LandownerJobPostView extends StatelessWidget {
  const LandownerJobPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: LandownerAppbar(
        title: Text(
          AppStrings.jobPost,
          textScaleFactor: 1,
        ),
      ),
      body: Center(
        child: Text(
          'JobPostView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
