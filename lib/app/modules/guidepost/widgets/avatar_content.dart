import 'package:flutter/material.dart';
import 'package:myray_mobile/app/modules/guidepost/widgets/avatar.dart';

class AvatarContent extends StatelessWidget {
  final String? imageUrl;
  final String? accountName;
  final Widget? child;
  const AvatarContent({
    Key? key,
    this.imageUrl,
    this.accountName,
    this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar(
          imageUrl: imageUrl,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                accountName ?? 'Ẩn danh',
                style: const TextStyle(fontSize: 15),
                textAlign: TextAlign.start,
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              child ?? const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
