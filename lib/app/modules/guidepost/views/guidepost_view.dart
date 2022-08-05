import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/guidepost/full_guidepost.dart';
import 'package:myray_mobile/app/data/models/guidepost/guidepost.dart';
import 'package:myray_mobile/app/modules/comment/widgets/comment_modal_bottom_sheet.dart';
import 'package:myray_mobile/app/modules/guidepost/controllers/guidepost_controller.dart';
import 'package:myray_mobile/app/modules/guidepost/widgets/avatar.dart';
import 'package:myray_mobile/app/modules/guidepost/widgets/avatar_content.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GuidePostView extends GetView<GuidepostController> {
  const GuidePostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bài hướng dẫn'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: controller.getGuidepost(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingBuilder();
            }
            return Obx(
              () => LazyLoadingList(
                width: Get.width,
                onEndOfPage: controller.getGuidepost,
                onRefresh: controller.onRefresh,
                itemCount: controller.fullGuidePostList.isEmpty
                    ? 1
                    : controller.fullGuidePostList.length,
                isLoading: controller.isLoading.value,
                itemBuilder: (context, index) {
                  if (snapshot.data == null ||
                      controller.fullGuidePostList.isEmpty) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.3),
                      child: Center(
                        child: Column(
                          children: [
                            Text("Không có bài viết nào.",
                                style: Get.textTheme.bodyLarge!.copyWith(
                                  color: AppColors.grey,
                                  fontSize: Get.textScaleFactor * 20,
                                ),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 10),
                            const ImageIcon(AssetImage(AppAssets.noGuiePost),
                                size: 30, color: AppColors.grey),
                          ],
                        ),
                      ),
                    );
                  }

                  Guidepost guidepost =
                      controller.fullGuidePostList[index].guidepost;
                  FullGuidepost fullGuidepost =
                      controller.fullGuidePostList[index];
                  return InkWell(
                    onTap: () {
                      controller.onShowDetail(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          AvatarContent(
                            imageUrl: fullGuidepost.account!.imageUrl,
                            accountName: fullGuidepost.account!.fullName,
                            child: Text(
                                'Ngày đăng: ${Utils.formatddMMyyyy(guidepost.createdDate)}',
                                style: Get.textTheme.bodySmall!
                                    .copyWith(fontSize: 10)),
                          ),
                          const SizedBox(
                            height: 14,
                          ),

                          //Tựa đề
                          Obx(
                            () => !controller.detailGuidePost[index]!
                                ? SizedBox(
                                    width: Get.width * 0.7,
                                    child: Text(
                                      guidepost.title,
                                      style: Get.textTheme.headline5!.copyWith(
                                        color: AppColors.brown,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      softWrap: true,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : const SizedBox(),
                          ),

                          // Html(
                          //   data: controller.changeTagType(guidepost.content),
                          //   shrinkWrap: true,
                          // ),
                          // Container(
                          //   padding: const EdgeInsets.all(10),
                          //   child: Html(
                          //     data:
                          //         controller.changeTagType(guidepost.content),
                          //     navigationDelegateForIframe:
                          //         (NavigationRequest request) {
                          //       if (request.url.contains("google.com/images")) {
                          //         return NavigationDecision.prevent;
                          //       } else {
                          //         return NavigationDecision.navigate;
                          //       }
                          //     },
                          //   ),
                          // ),
                          Obx(
                            () => controller.detailGuidePost[index]!
                                ? Html.fromDom(
                                    document:
                                        HtmlParser.parseHTML(guidepost.content),
                                  )
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 15.5,
                                      ),
                                      Text(
                                        'Xem chi tiết',
                                        style: Get.textTheme.labelMedium!
                                            .copyWith(
                                                fontSize: 14,
                                                color: AppColors.bluePastel),
                                      ),
                                    ],
                                  ),
                          ),
                          //content

                          Divider(
                              color: Colors.grey.withOpacity(0.5),
                              indent: 15,
                              endIndent: 15,
                              height: 10),
                          const SizedBox(
                            height: 10,
                          ),
                          //Bình luận nút
                          InkWell(
                            onTap: () {
                              print('open dialog comment');
                              CommentModalBottomSheet.showCommentBox(
                                  context: context,
                                  guidePostId: guidepost.id,
                                  commentAccount: controller.commentAccount);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.mode_comment_outlined,
                                  size: 20,
                                  color: AppColors.primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  AppStrings.labelComment,
                                  style: Get.textTheme.button!.copyWith(
                                    fontSize: Get.textScaleFactor * 17,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ));
  }
}
