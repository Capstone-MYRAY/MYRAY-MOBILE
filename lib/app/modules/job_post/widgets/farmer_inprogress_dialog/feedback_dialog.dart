import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_form_dialog.dart';

class FeedbackDialog {
  FeedbackDialog._();
  static int size = 17;
  static show({
    required int jobPostId,
    required GlobalKey<FormState> formKey,
    required TextEditingController feedbackRatingController,
    required TextEditingController feedbackContentController,
    required void Function(int?) submit,
    required String? Function(String?) validateReason,
    required void Function() closeDialog,
    required bool isReported,
    required double initialRating,
    void Function()? delete,
  }) {
    return CustomFormDialog.showDialog(
        title: 'Đánh giá',
        formKey: formKey,
        contentPadding: const EdgeInsets.only(left: 20, right: 10),
        textFields: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: initialRating,
                minRating: 1,
                direction: Axis.horizontal,
                itemSize: Get.textScaleFactor * 35,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  feedbackRatingController.text = rating.toInt().toString();
                  print(feedbackRatingController.text);
                },
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: "Chạm vào sao để đánh giá.",
                        style: Get.textTheme.caption),
                  ],
                ),
                style: TextStyle(
                  fontSize: Get.textScaleFactor * 17,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InputField(
              key: UniqueKey(),
              controller: feedbackContentController,
              icon: const Icon(Icons.feedback_outlined),
              labelText: "Ý kiến",
              placeholder: 'Nhập ý kiến',
              keyBoardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 10,
              validator: validateReason,
            ),
          ),
        ],
        widget: isReported
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        CustomTextButton(
                          onPressed: () {
                            submit(jobPostId);
                          },
                          title: 'Cập nhật',
                        ),
                      ],
                    ),
                  ),
                  delete != null
                      ? IntrinsicHeight(
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              CustomTextButton(
                                  onPressed: delete,
                                  title: 'Xóa',
                                  background: AppColors.white,
                                  foreground: AppColors.errorColor,
                                  textStyle:
                                      Get.textTheme.displayMedium!.copyWith(
                                    color: AppColors.errorColor,
                                    fontSize: Get.textScaleFactor * size,
                                  ),
                                  padding: EdgeInsets.zero),
                              const SizedBox(
                                width: 5,
                              ),
                              const VerticalDivider(
                                  color: AppColors.errorColor,
                                  indent: 10,
                                  endIndent: 10),
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        )
                      : const Text(''),
                  const SizedBox(
                    width: 5,
                  ),
                  CustomTextButton(
                    onPressed: closeDialog,
                    title: 'Quay lại',
                    background: AppColors.white,
                    border: Border.all(
                      color: AppColors.primaryColor,
                    ),
                    textStyle: Get.textTheme.button!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  )
                ],
              )
            : null,
        onSubmit: isReported
            ? null
            : () {
                submit(jobPostId);
              },
        onCancel: isReported ? null : closeDialog);
  }
}
