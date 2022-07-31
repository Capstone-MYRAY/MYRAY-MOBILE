import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';

class FilterControls extends StatelessWidget {
  final void Function()? onApply;
  final void Function()? onClear;
  const FilterControls({
    Key? key,
    this.onApply,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: OutlinedButton(
              onPressed: onClear,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
              child: const Text(AppStrings.titleClearFilter),
            ),
          ),
          const SizedBox(width: 24.0),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: FilledButton(
              title: AppStrings.titleApply,
              onPressed: onApply,
              padding: const EdgeInsets.symmetric(vertical: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}
