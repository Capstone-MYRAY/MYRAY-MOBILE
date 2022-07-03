import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_controller.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/landowner_job_post_item.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/hex_color_extension.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
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
      body: FutureBuilder(
        future: controller.getJobPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBuilder();
          }

          if (snapshot.data == null) {
            return ListEmptyBuilder(onRefresh: controller.onRefresh);
          }

          if (snapshot.hasData) {
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
                    address: jobPost.address,
                    publishedDate: jobPost.publishedDate,
                    backgroundColor: jobPost.backgroundColor != null
                        ? HexColor.fromHex(jobPost.backgroundColor!)
                        : null,
                    foregroundColor: jobPost.foregroundColor != null
                        ? HexColor.fromHex(jobPost.foregroundColor!)
                        : null,
                    treeTypes: jobPost.treeJobs,
                    workType: jobPost.workType,
                    onDetailsPress: () {},
                  );
                }),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
