import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/comment/comment.dart';
import 'package:myray_mobile/app/modules/comment/controllers/comment_controller.dart';
import 'package:myray_mobile/app/modules/comment/widgets/comment_function_bottom_sheet.dart';
import 'package:myray_mobile/app/modules/comment/widgets/comment_container_widget.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class CommentModalBottomSheet {
  CommentModalBottomSheet._();

  static showCommentBox({
    required BuildContext context,
    required int guidePostId,
    Account? commentAccount,
  }) {
    CommentController controller = Get.find<CommentController>();
    bool isFarmer = controller.isFarmer;
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
                      userImage: commentAccount == null
                          ? (isFarmer
                              ? 'https://i.im.ge/2022/08/02/Fy6jHr.farmer.png'
                              : 'https://i.im.ge/2022/08/02/Fy69ym.landowner.png')
                          : commentAccount.imageUrl ??
                              (isFarmer
                                  ? 'https://i.im.ge/2022/08/02/Fy6jHr.farmer.png'
                                  : 'https://i.im.ge/2022/08/02/Fy69ym.landowner.png'),
                      labelText: 'Bình luận...',
                      withBorder: false,
                      errorText: 'Comment cannot be blank',
                      sendButtonMethod: () async {
                        controller.onCreateComment(
                            guidePostId, context, commentAccount!);
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
                            return const MyLoadingBuilder();
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
                                  String userRole = controller.roleUser;
                                  print('user role: $userRole');
                                  return CommentContainer(
                                      name: comment.fullname ?? 'Ẩn danh',
                                      comment: comment.content,
                                      commentDateTime: comment.createDate,
                                      imageUrl: comment.avatar,
                                      onLongPress: () {
                                        comment.commentBy == userId
                                            ? CommentFunctionBottomSheet
                                                .showMenu(
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
                                                          confirmTitle:
                                                              AppStrings
                                                                  .titleDelete);
                                                    },
                                                    edit: () {
                                                      Get.back(); //Tắt menu
                                                      controller
                                                          .onCloseComment();
                                                      controller.onEditComment(
                                                          context, comment);
                                                    })
                                            : null;
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
