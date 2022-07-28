import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class AvatarUpdate extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback onTapHandlerImage;
  final VoidCallback onTapHandlerIcon;
  final IconData icon;
  const AvatarUpdate({
    Key? key,
    required this.image,
    required this.onTapHandlerImage,
    required this.onTapHandlerIcon,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: Stack(
          children: [
            _buildImage(),
            Positioned(
              bottom: 0,
              right: 4,
              child: GestureDetector(
                onTap: onTapHandlerIcon,
                child: _buildEditIcon(AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditIcon(Color color) {
    return _buildCircle(
      color: Colors.white,
      all: 4,
      child: _buildCircle(
        color: color,
        all: 8,
        child: Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCircle(
      {required Color color, required double all, Widget? child}) {
    return ClipOval(
      child: Container(
        color: color,
        padding: EdgeInsets.all(all),
        child: child,
      ),
    );
  }

  Widget _buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 144,
          height: 144,
          child: InkWell(
            onTap: onTapHandlerImage,
          ),
        ),
      ),
    );
  }
}
