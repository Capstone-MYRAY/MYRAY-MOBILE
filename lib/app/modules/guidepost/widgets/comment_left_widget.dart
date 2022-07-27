import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';

class CommentLeft extends StatelessWidget {
  final String name;
  final String comment;
  // final ulrImage;
  const CommentLeft({Key? key, required this.name, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        const CircleAvatar(
          child: Icon(Icons.person),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            SizedBox(
              width: Get.width * 0.5,
              child: Text(
                name,
                style: Get.textTheme.labelMedium!,
                softWrap: true,
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: SizedBox(
                width: Get.width * 0.5,
                child: Text(
                  comment,
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
