import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/comment/comment.dart';
import 'package:myray_mobile/app/data/models/comment/post_comment_request.dart';
import 'package:myray_mobile/app/modules/comment/controllers/comment_controller.dart';
import 'package:myray_mobile/app/modules/guidepost/widgets/comment_left_widget.dart';
import 'package:myray_mobile/app/modules/guidepost/widgets/comment_right_widget.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class CommentModalBottomSheet {
  CommentModalBottomSheet._();

  static showCommentBox({
    required BuildContext context,
    required int guidePostId,
  }) {
    CommentController controller = Get.find<CommentController>();
    return showModalBottomSheet(
      backgroundColor: AppColors.white,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      context: context,
      builder: ((context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: Get.height * 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        AppStrings.labelComment,
                        style: Get.textTheme.headline5!.copyWith(
                          fontSize: Get.textScaleFactor * 20,
                        ),
                      ),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.cancel,
                          size: 25,
                        ),
                        onPressed: () {
                          Get.back();
                          controller.commentController.clear();
                        }),
                  ],
                ),
                Divider(
                  color: Colors.black.withOpacity(0.5),
                  indent: 20,
                  endIndent: 30,
                  // height: 10,
                ),
                // Expanded(
                //     child: ListView.builder(
                //       reverse: true,
                //       itemCount: 10,
                //       itemBuilder: (context, index) {
                //         return index % 2 == 0
                //             ? const CommentLeft(
                //                 name: 'Nông dân A',
                //                 comment: 'Bài viết hay',
                //               )
                //             : const CommentRight(
                //                 name: 'Nông dân B', comment: 'Bài viết bổ ích');
                //       },
                //     ),
                //   ),

                Expanded(
                  // height: 70,
                  child: CommentBox(
                      userImage:
                          'https://cn.i.cdn.ti-platform.com/content/20/the-amazing-world-of-gumball/showpage/za/gumball-carousel.a94b8e60.png',
                      labelText: 'Write a comment...',
                      withBorder: false,
                      errorText: 'Comment cannot be blank',
                      sendButtonMethod: () async {
                        if (controller.formKey.currentState!.validate()) {
                          print(controller.commentController.text);
                          PostCommentRequest data = PostCommentRequest(
                            guidepostId: guidePostId,
                            content: controller.commentController.text,
                          );
                          Comment? comment =
                              await controller.createComment(data);
                          if(comment != null){
                            controller.commentList.add(comment);
                          }
                          controller.commentController.clear();
                          FocusScope.of(context).unfocus();
                        } else {
                          print("Not validated");
                        }
                      },
                      formKey: controller.formKey,
                      commentController: controller.commentController,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      sendWidget: const Icon(Icons.send_sharp,
                          size: 30, color: AppColors.primaryColor),
                      child: FutureBuilder(
                            future: controller.getComments(guidePostId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const LoadingBuilder();
                              }
                              return Obx(() => LazyLoadingList(
                                    onEndOfPage: () =>
                                        controller.getComments(guidePostId),
                                    onRefresh: () =>
                                        controller.onRefresh(guidePostId),
                                    isLoading: controller.isLoading.value,
                                    itemCount: controller.commentList.isEmpty
                                        ? 1
                                        : controller.commentList.length,
                                    itemBuilder: (context, index) {
                                      if (snapshot.data == null ||
                                          controller.commentList.isEmpty) {
                                        return Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Không có bình luận nào.",
                                                style: Get.textTheme.bodyLarge!
                                                    .copyWith(
                                                  color: AppColors.grey,
                                                  fontSize:
                                                      Get.textScaleFactor * 20,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const Icon(
                                                  Icons.mode_comment_rounded,
                                                  size: 30,
                                                  color: AppColors.grey),
                                            ],
                                          ),
                                        );
                                      }
                                      Comment comment =
                                          controller.commentList[index];
                                      int userId =
                                          AuthCredentials.instance.user!.id!;
                                      return comment.commentBy == userId
                                          ? CommentRight(
                                              name: 'Nông dân B',
                                              comment: comment.content)
                                          : CommentLeft(
                                              name: 'Nông dân A',
                                              comment: comment.content,
                                            );
                                    },
                                  ));
                            },
                          )

                      //   ListView.builder(
                      //   reverse: true,
                      //   itemCount: 10,
                      //   itemBuilder: (context, index) {
                      // return index % 2 == 0
                      //     ? const CommentLeft(
                      //         name: 'Nông dân A',
                      //         comment: 'Bài viết hay',
                      //       )
                      //     : const CommentRight(
                      //         name: 'Nông dân B', comment: 'Bài viết bổ ích');
                      //   },
                      // ),
                      ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
