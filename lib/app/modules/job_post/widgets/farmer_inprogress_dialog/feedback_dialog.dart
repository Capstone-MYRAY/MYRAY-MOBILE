
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_form_dialog.dart';

class FeedbackDialog{
 FeedbackDialog._();

 static show({
  required int jobPostId,
  required GlobalKey<FormState> formKey,
  required TextEditingController feedbackRatingController,
  required TextEditingController feedbackContentController,
  required void Function(int?) submit,
  required String? Function(String?) validateReason,
  required void Function() closeDialog,
 }){
    return CustomFormDialog.showDialog(
        title: 'Đánh giá',
        formKey: formKey,
        textFields: [
          RatingBar.builder(
            initialRating: 1,
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
              feedbackRatingController.text =
                  rating.toInt().toString();
              print(feedbackRatingController.text);
            },
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
          InputField(
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
        ],
        submit: () {
          submit(jobPostId);
        },
        submitButtonTitle: 'Đánh giá',
        cancel: closeDialog);
  }
 }
  
