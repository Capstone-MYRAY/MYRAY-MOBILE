import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_controller.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/filters/job_post_filter.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/landowner_job_post_item.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/hex_color_extension.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/controls/search_and_filter.dart';
import 'package:myray_mobile/app/shared/widgets/landowner_appbar.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class LandownerJobPostView extends GetView<LandownerJobPostController> {
  const LandownerJobPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LandownerAppbar(
        title: Text(
          AppStrings.jobPost,
          textScaleFactor: 1,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () {
          controller.navigateToCreateForm();
        },
      ),
      body: Column(
        children: [
          SearchAndFilter(
            searchController: controller.titleController,
            onTextChanged: (value) {
              controller.titleFilter = value;
              controller.onRefresh(isFilter: true);
            },
            onFilterTap: () {
              Get.to(
                () => JobPostFilter(),
                transition: Transition.leftToRight,
              );
            },
            refreshOnClear: true,
          ),
          Expanded(
            child: GetBuilder<LandownerJobPostController>(
              builder: (_) => FutureBuilder(
                future: controller.getJobPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const MyLoadingBuilder();
                  }

                  if (snapshot.data == null) {
                    return ListEmptyBuilder(
                      onRefresh: controller.onRefresh,
                      msg: 'Không có bài đăng nào',
                    );
                  }

                  if (snapshot.hasData) {
                    return GestureDetector(
                      onPanDown: (_) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: _buildContent(),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Obx(
      () => LazyLoadingList(
        onEndOfPage: controller.getJobPosts,
        isLoading: controller.isLoading.value,
        onRefresh: controller.onRefresh,
        itemCount: controller.jobPosts.length,
        itemBuilder: ((context, index) {
          JobPost jobPost = controller.jobPosts[index];
          return LandownerJobPostItem(
            key: ValueKey(jobPost.id),
            title: jobPost.title,
            gardenName: jobPost.gardenName ?? '',
            workType: jobPost.workTypeName,
            address: jobPost.address ?? '',
            publishedDate: jobPost.publishedDate,
            postTypeBackground: jobPost.backgroundColor != null
                ? HexColor.fromHex(jobPost.backgroundColor!)
                : null,
            postTypeForeground: jobPost.foregroundColor != null
                ? HexColor.fromHex(jobPost.foregroundColor!)
                : null,
            treeTypes: jobPost.treeTypes,
            workPayType: jobPost.workPayType,
            // expiredDate: jobPost.publishedDate.add(
            //   Duration(days: jobPost.numOfPublishDay - 1),
            // ),
            pinType: jobPost.postTypeName,
            postStatusBackground: jobPost.jobPostStatusColor,
            workStatusBackground: jobPost.jobPostWorkStatusColor,
            postStatusString: jobPost.jobPostStatusString,
            workStatusString: jobPost.jobPostWorkStatusString,
            onDetailsPress: () {
              Get.toNamed(
                Routes.landownerJobPostDetails,
                arguments: {
                  Arguments.tag: jobPost.id.toString(),
                  Arguments.item: jobPost,
                },
              );
            },
          );
        }),
      ),
    );
  }
}
