import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_circle_avatar.dart';
import 'package:myray_mobile/app/shared/widgets/image/round_image.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String? message;
  final String? avatar;
  final String? imageUrl;
  final DateTime? createdDate;
  final bool isSameTime;

  const MessageBubble({
    Key? key,
    this.message,
    this.avatar,
    this.imageUrl,
    this.isMe = false,
    this.createdDate,
    this.isSameTime = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe) _buildAvatar(),
            Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 8.0,
                    right: 8.0,
                  ),
                  child: Text(
                    Utils.formatMessageDateTime(createdDate ?? DateTime.now()),
                    style: Get.textTheme.caption!.copyWith(
                      fontSize: 11 * Get.textScaleFactor,
                    ),
                  ),
                ),
                if (message != null) _buildTextMsg(context),
                if (imageUrl != null) _buildImageMsg(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  _buildTextMsg(context) {
    return Container(
      decoration: BoxDecoration(
        color: isMe
            ? Theme.of(context).primaryColor.withOpacity(0.5)
            : Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(12),
          topRight: const Radius.circular(12),
          bottomLeft: !isMe ? Radius.zero : const Radius.circular(12.0),
          bottomRight: isMe ? Radius.zero : const Radius.circular(12.0),
        ),
      ),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      margin: EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
        right: isMe ? 8.0 : 0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 12.0,
      ),
      child: Text(
        message ?? '',
        textAlign: TextAlign.left,
      ),
    );
  }

  _buildImageMsg() {
    return Container(
      margin: EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
        right: isMe ? 8.0 : 0,
      ),
      child: RoundImage(
        width: Get.width * 0.7,
        imageUrl: imageUrl,
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CustomCircleAvatar(
        radius: 14,
        url: avatar,
      ),
    );
  }
}
