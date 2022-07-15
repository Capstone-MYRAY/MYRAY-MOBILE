import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_circle_avatar.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String? message;
  final String? avatar;
  final String? imageUrl;

  const MessageBubble({
    Key? key,
    this.message,
    this.avatar,
    this.imageUrl,
    this.isMe = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isMe) _buildAvatar(),
        Column(
          children: [
            if (message != null) _buildTextMsg(context),
            if (imageUrl != null) _buildImageMsg(),
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
      width: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Utils.isNetworkImage(imageUrl!)
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.fill,
                )
              : Image.file(
                  File(imageUrl!),
                  fit: BoxFit.fill,
                ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (Utils.isNetworkImage(imageUrl!)) {
      return Image.network(imageUrl!);
    } else {
      return Image.file(File(imageUrl!));
    }
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
