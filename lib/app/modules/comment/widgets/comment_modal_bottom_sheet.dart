import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:myray_mobile/app/data/models/comment/comment.dart';
import 'package:myray_mobile/app/data/models/comment/post_comment_request.dart';
import 'package:myray_mobile/app/modules/comment/controllers/comment_controller.dart';
import 'package:myray_mobile/app/modules/comment/widgets/comment_function_bottom_sheet.dart';
import 'package:myray_mobile/app/modules/comment/widgets/comment_left_widget.dart';
import 'package:myray_mobile/app/modules/comment/widgets/comment_right_widget.dart';
import 'package:myray_mobile/app/modules/comment/widgets/comment_update_bottom_sheet.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';
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
      enableDrag: false,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      isScrollControlled: true,
      context: context,
      builder: ((context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: Get.height * 0.7,
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
                        icon: Icon(
                          Icons.cancel,
                          size: 30,
                          color: AppColors.iconColor,
                        ),
                        onPressed: controller.onCloseComment),
                  ],
                ),
                Divider(
                  color: Colors.black.withOpacity(0.5),
                  indent: 20,
                  endIndent: 30,
                  height: 10,
                ),
                Expanded(
                  // height: 70,
                  child: CommentBox(
                      userImage:
                          'https://cn.i.cdn.ti-platform.com/content/20/the-amazing-world-of-gumball/showpage/za/gumball-carousel.a94b8e60.png',
                      labelText: 'Bình luận...',
                      withBorder: false,
                      errorText: 'Comment cannot be blank',
                      sendButtonMethod: () async {
                        if (controller.validateInputComment(
                            controller.commentController.text.trim())) {
                          // print(controller.commentController.text.trim());
                          PostCommentRequest data = PostCommentRequest(
                            guidepostId: guidePostId,
                            content: controller.commentController.text,
                          );
                          Comment? comment =
                              await controller.createComment(data);
                          if (comment != null) {
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
                                          const Icon(Icons.mode_comment_rounded,
                                              size: 30, color: AppColors.grey),
                                        ],
                                      ),
                                    );
                                  }
                                  Comment comment =
                                      controller.commentList[index];
                                  int userId = controller.currentUser;
                                  return comment.commentBy != userId
                                      ? CommentLeft(
                                          name: 'Nông dân A',
                                          comment: comment.content,
                                        )
                                      : CommentRight(
                                          name: 'Nông dân B',
                                          comment: comment.content,
                                          onLongPress: () {
                                            CommentFunctionBottomSheet.showMenu(
                                                context: context,
                                                delete: () {
                                                  CustomDialog.show(
                                                      confirm: () {
                                                        Get.back(); //tắt bottom sheet function menu
                                                        controller
                                                            .onDeleteComment(
                                                                comment.id);
                                                      },
                                                      message: AppStrings
                                                          .confirmDeleteMessage,
                                                      confirmTitle: AppStrings
                                                          .titleDelete);
                                                },
                                                edit: () {
                                                  Get.back(); //Tắt menu
                                                  controller.onCloseComment();
                                                  controller.onEditComment(context, comment);
                                                });
                                          });
                                },
                              ));
                        },
                      )),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
