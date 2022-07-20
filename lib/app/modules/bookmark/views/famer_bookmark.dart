import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/bookmark/bookmark.dart';
import 'package:myray_mobile/app/modules/bookmark/controllers/farmer_bookmark_controller.dart';
import 'package:myray_mobile/app/modules/bookmark/widgets/bookmark_card.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class FarmerBookmark extends GetView<FarmerBookmarkController> {
  const FarmerBookmark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yêu thích'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getAllBookmarkAccount(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBuilder();
          }
          if (snapshot.hasError) {
            printError(info: snapshot.error.toString());
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error,
                    size: 50.0,
                    color: AppColors.errorColor,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Đã có lỗi xảy ra',
                    style: Get.textTheme.headline6!.copyWith(
                      color: AppColors.errorColor,
                    ),
                  ),
                ],
              ),
            );
          }

          return Obx(() => LazyLoadingList(
              onEndOfPage: controller.getAllBookmarkAccount,
              onRefresh: controller.onRefresh,
              isLoading: controller.isLoading.value,
              itemCount: controller.listBookmark.isNotEmpty
                  ? controller.listBookmark.length
                  : 1,
              itemBuilder: (context, index) {
                if (snapshot.data == null || controller.listBookmark.isEmpty) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.3),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Không có tài khoản yêu thích nào.",
                            style: Get.textTheme.bodyLarge!.copyWith(
                              color: AppColors.grey,
                              fontSize: Get.textScaleFactor * 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Icon(
                            CustomIcons.account_heart_outline,
                            size: 25,
                            color: AppColors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                Bookmark bookmark = controller.listBookmark[index];
                return Container(
                  padding: EdgeInsets.only(top: Get.height * 0.02),
                  child: BookmarkCard(
                    fullName: bookmark.bookmarkNavigation.fullName,
                    onViewDetails: () {
                      print('show detail');
                    },
                    onToggleBookmark: () {
                      controller
                          .unBookmarkAccount(bookmark.bookmarkNavigation.id!);
                      print('unbookmark, remove from list');
                    },
                  ),
                );
              }));
        }),
      ),
    );
  }
}
