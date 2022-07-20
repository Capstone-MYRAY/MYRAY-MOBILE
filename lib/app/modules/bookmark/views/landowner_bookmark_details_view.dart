import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/bookmark/controllers/landowner_bookmark_details_controller.dart';
import 'package:myray_mobile/app/shared/widgets/farmer_details/farmer_details.dart';
import 'package:myray_mobile/app/shared/widgets/farmer_details/farmer_details_appbar.dart';

class LandownerBookmarkDetailsView
    extends GetView<LandownerBookmarkDetailsController> {
  const LandownerBookmarkDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FarmerDetailsAppbar(
        title: controller.user.fullName ?? '',
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => FarmerDetails(
                  isChatButtonDisplayed: false,
                  rating: controller.user.rating,
                  onFavoriteToggle: controller.onToggleBookmark,
                  isBookmarked: controller.isBookmarked.value,
                  avatar: controller.user.imageUrl,
                  role: controller.user.roleName,
                  user: Rx(controller.user),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
