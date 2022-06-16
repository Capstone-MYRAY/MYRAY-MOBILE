import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';

class FilledButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final double minWidth;
  final double minHeight;

  const FilledButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.minWidth = double.infinity,
    this.minHeight = CommonConstants.buttonHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          Size(minWidth, minHeight),
        ),
      ),
      child: Text(title),
    );
  }
}
