
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';

class SimpleIcon extends StatelessWidget {
  const SimpleIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Image.asset(AppAssets.cultivation, width: Get.width * 0.3),
        ],
      );
    
  }
}