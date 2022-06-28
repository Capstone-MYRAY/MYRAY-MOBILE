import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class MyCheckBox extends StatelessWidget {
  final bool value;
  final void Function(bool?) onChanged;
  final Color? checkColor;
  final Color? filledColor;
  final BorderSide? borderSide;
  const MyCheckBox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.checkColor,
    this.filledColor,
    this.borderSide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      checkColor: checkColor ?? AppColors.white,
      fillColor:
          MaterialStateProperty.all(filledColor ?? AppColors.primaryColor),
      side: borderSide ?? const BorderSide(color: AppColors.black, width: 1.2),
      onChanged: onChanged,
    );
  }
}
