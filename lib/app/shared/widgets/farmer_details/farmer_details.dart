import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/modules/profile/widgets/personal_information_card.dart';
import 'package:myray_mobile/app/shared/widgets/farmer_details/farmer_avatar_info.dart';

class FarmerDetails extends StatelessWidget {
  final String? avatar;
  final String role;
  final double? rating;
  final String? statusName;
  final Color? statusColor;
  final bool isBookmarked;
  final bool isChatButtonDisplayed;
  final void Function()? navigateToChatScreen;
  final void Function()? onFavoriteToggle;
  final Rx<Account> user;

  const FarmerDetails({
    Key? key,
    required this.role,
    required this.user,
    this.avatar,
    this.rating,
    this.statusName,
    this.statusColor,
    this.isBookmarked = false,
    this.isChatButtonDisplayed = true,
    this.navigateToChatScreen,
    this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FarmerAvatarInfo(
          role: role,
          avatar: avatar,
          rating: rating,
          statusColor: statusColor,
          statusName: statusName,
          isChatButtonDisplayed: isChatButtonDisplayed,
          onFavoriteToggle: onFavoriteToggle,
          navigateToChatScreen: navigateToChatScreen,
          isBookmarked: isBookmarked,
        ),
        const SizedBox(height: 16.0),
        PersonalInformation(user: user),
      ],
    );
  }
}
