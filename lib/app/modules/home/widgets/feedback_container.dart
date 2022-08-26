import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class FeedBackContainer extends StatelessWidget {
  final FeedBack feedBack;
  const FeedBackContainer({Key? key, required this.feedBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingBarIndicator(
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize: 20,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            rating: double.parse(feedBack.numStar.toString()),
          ),
          const SizedBox(height: 2.0),
          Text(
            Utils.formatddMMyyyy(feedBack.createdDate),
            style: Get.textTheme.caption,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: Get.width * 0.9,
            child: Text(
              feedBack.content,
              style: Get.textTheme.bodyMedium!.copyWith(fontSize: 15),
              softWrap: true,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 50,
            ),
          ),
          Divider(
            color: AppColors.grey.withOpacity(0.1),
            height: 10,
            endIndent: 10,
          ),
        ],
      ),
    );
  }
}
