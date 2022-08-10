import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';

class ListEmptyBuilder extends StatelessWidget {
  final Future<void> Function()? onRefresh;
  final String msg;
  final String? nameImage;
  const ListEmptyBuilder({
    Key? key,
    this.onRefresh,
    this.msg = AppStrings.noData,
    this.nameImage = AppAssets.emptyFolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset(nameImage!),
              Text(
                msg,
                style: Get.textTheme.headline5,
              ),
              if (onRefresh != null)
                FractionallySizedBox(
                  widthFactor: 0.3,
                  child: TextButton(
                    onPressed: onRefresh,
                    child: Text('Tải lại', style: Get.textTheme.headline6),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
