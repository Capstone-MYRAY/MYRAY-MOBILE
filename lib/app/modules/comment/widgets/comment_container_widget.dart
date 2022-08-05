import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/guidepost/widgets/avatar.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class CommentContainer extends StatelessWidget {
  final String name;
  final String comment;
  final String? imageUrl;
  final void Function()? onLongPress;
  final DateTime commentDateTime;

  const CommentContainer({
    Key? key,
    required this.name,
    required this.comment,
    required this.commentDateTime,
    this.imageUrl,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Avatar(
              width: 40,
              height: 40,
              imageUrl: imageUrl,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          width: Get.width * 0.5,
                          child: Text(
                            name,
                            style: Get.textTheme.labelMedium!.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            softWrap: true,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.5,
                          child: Text(
                            Utils.formatHHmmddMMyyyy(commentDateTime.toLocal()),
                            style:
                                Get.textTheme.bodySmall!.copyWith(fontSize: 10),
                            softWrap: true,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 5),
                  InkWell(
                    onLongPress: onLongPress,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: Get.width * 0.6,
                        child: Text(
                          comment,
                          softWrap: true,
                          textAlign: TextAlign.justify,
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
