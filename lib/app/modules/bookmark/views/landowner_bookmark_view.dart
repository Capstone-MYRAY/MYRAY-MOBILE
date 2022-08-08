import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/bookmark/bookmark.dart';
import 'package:myray_mobile/app/modules/bookmark/controllers/landowner_bookmark_controller.dart';
import 'package:myray_mobile/app/modules/bookmark/widgets/bookmark_card.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class LandownerBookmarkView extends StatelessWidget {
  const LandownerBookmarkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleFavoriteList),
      ),
      body: GetBuilder<LandownerBookmarkController>(
        builder: (controller) => FutureBuilder(
          future: controller.getBookmarks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingBuilder();
            }

            if (snapshot.data == null || controller.bookmarks.isEmpty) {
              return ListEmptyBuilder(
                onRefresh: controller.onRefresh,
                msg: AppMsg.MSG5007,
              );
            }

            if (snapshot.hasData && controller.bookmarks.isNotEmpty) {
              return Obx(
                () => LazyLoadingList(
                  onEndOfPage: controller.getBookmarks,
                  isLoading: controller.isLoading.value,
                  onRefresh: controller.onRefresh,
                  itemCount: controller.bookmarks.length,
                  itemBuilder: ((context, index) {
                    Bookmark bookmark = controller.bookmarks[index];
                    return BookmarkCard(
                      fullName: bookmark.bookmarkNavigation.fullName,
                      avatar: bookmark.bookmarkNavigation.imageUrl,
                      isBookmarked: bookmark.isBookmarked,
                      phone: bookmark.bookmarkNavigation.phoneNumber,
                      onToggleBookmark: () => controller.onToggleBookmark(
                        bookmark.isBookmarked,
                        bookmark.bookmarkId,
                      ),
                      onViewDetails: () {
                        Get.toNamed(Routes.landownerBookmarkDetails,
                            arguments: {
                              Arguments.item: bookmark.bookmarkNavigation,
                              Arguments.isBookmarked: bookmark.isBookmarked,
                            });
                      },
                    );
                  }),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
