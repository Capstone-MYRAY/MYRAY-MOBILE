import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class ListEmptyBuilder extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final String msg;
  const ListEmptyBuilder({
    Key? key,
    required this.onRefresh,
    this.msg = AppStrings.noData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                Image.asset(AppAssets.emptyFolder),
                Text(
                  msg,
                  style: Get.textTheme.headline5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
