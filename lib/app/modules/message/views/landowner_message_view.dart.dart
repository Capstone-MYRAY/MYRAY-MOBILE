import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/landowner_appbar.dart';

class LandownerMessageView extends StatelessWidget {
  const LandownerMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: LandownerAppbar(
        title: Text(
          AppStrings.message,
          textScaleFactor: 1,
        ),
      ),
      body: Center(
        child: Text(
          'MessageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
