import 'package:flutter/material.dart';
import 'package:myray_mobile/app/modules/message/widgets/landowner_messages/landowner_message_list.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/landowner_appbar.dart';

class LandownerMessageView extends StatelessWidget {
  const LandownerMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LandownerAppbar(
        title: Text(
          AppStrings.message,
          textScaleFactor: 1,
        ),
      ),
      body: LandownerMessageList(),
    );
  }
}
