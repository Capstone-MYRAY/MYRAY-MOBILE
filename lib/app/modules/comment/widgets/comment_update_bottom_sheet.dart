import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/comment/comment.dart';
import 'package:myray_mobile/app/modules/comment/widgets/comment_modal_bottom_sheet.dart';
import 'package:myray_mobile/app/modules/guidepost/widgets/avatar.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';

class CommentUpdateBottomSheet {
  CommentUpdateBottomSheet._();

  static showUpdateForm({
    required BuildContext buildContext,
    required GlobalKey<FormState> formKey,
    required TextEditingController editCommentController,
    required Comment comment,
    required String? Function(String?) validateComment,
    required void Function() update,
    void Function()? cancel,
    final String? imageUrl,
  }) {
    return showModalBottomSheet(
        context: buildContext,
        enableDrag: false,
        backgroundColor: AppColors.white,
        barrierColor: Colors.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          editCommentController.text = comment.content;
          return Padding(
             padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
                height: Get.height * 0.7,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Avatar(
                          width: 50,
                          height: 50,
                          imageUrl: imageUrl,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: Get.width * 0.7,
                          child: Form(
                            key: formKey,
                            child: TextFormField(
                              controller: editCommentController,
                              keyboardType: TextInputType.multiline,
                              validator: validateComment,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextButton(
                            onPressed: () {
                              update();
                              // print('comment id: ${comment.id}');
                              editCommentController.clear();
                              Get.back(); //Tắt edit bottom sheet
                              CommentModalBottomSheet.showCommentBox(
                                  context: context,
                                  guidePostId: comment.guidepostId);
                            },
                            title: 'Cập nhật'),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomTextButton(
                            background: AppColors.white,
                            foreground: AppColors.primaryColor,
                            border: Border.all(
                              color: AppColors.primaryColor,
                            ),
                            onPressed: cancel ??
                                () {
                                  editCommentController.clear();
                                  Get.back(); //Tắt edit bottom sheet
                                  CommentModalBottomSheet.showCommentBox(
                                      context: context,
                                      guidePostId: comment.guidepostId);
                                },
                            title: 'Quay lại'),
                      ],
                    )
                  ],
                )),
          );
        });
  }
}
