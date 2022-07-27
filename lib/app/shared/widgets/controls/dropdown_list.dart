import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class DropdownList<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final void Function(T? value)? onChanged;
  final T? value;
  final double? width;

  const DropdownList({
    Key? key,
    required this.items,
    required this.onChanged,
    this.width,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      width: width ?? Get.width * 0.9,
      child: Material(
        elevation: 2.0,
        color: AppColors.white,
        borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: DropdownButton<T>(
            items: items,
            isExpanded: true,
            value: value,
            onChanged: onChanged,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            underline: const SizedBox(),
          ),
        ),
      ),
    );
  }
}
