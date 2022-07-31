import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LazyLoadingList extends StatelessWidget {
  final bool isLoading;
  final int itemCount;
  final double? width;
  final Function() onEndOfPage;
  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool reverse;
  final ScrollPhysics? scrollPhysics;
  final bool shrinkWrap;

  const LazyLoadingList({
    Key? key,
    required this.onEndOfPage,
    required this.onRefresh,
    required this.itemCount,
    required this.itemBuilder,
    this.isLoading = false,
    this.width,
    this.reverse = false,
    this.scrollPhysics,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: SizedBox(
          width: width ?? Get.width * 0.9,
          child: LazyLoadScrollView(
            onEndOfPage: onEndOfPage,
            isLoading: isLoading,
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListView(
                  shrinkWrap: shrinkWrap,
                  physics: scrollPhysics,
                  reverse: reverse,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: itemCount,
                      itemBuilder: itemBuilder,
                    ),
                    isLoading
                        ? JumpingDotsProgressIndicator(
                            fontSize: 40.0,
                            color: AppColors.primaryColor,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
