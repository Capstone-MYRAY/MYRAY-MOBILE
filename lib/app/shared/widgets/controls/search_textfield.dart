import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/debouncer.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController searchController;
  final void Function(String)? onChanged;

  SearchTextField({
    Key? key,
    required this.searchController,
    this.onChanged,
  }) : super(key: key);

  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return ObxValue<RxBool>(
      (isEmpty) => TextField(
        controller: searchController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
          ),
          suffix: !isEmpty.value
              ? GestureDetector(
                  onTap: () {
                    searchController.clear();
                    isEmpty.value = true;
                  },
                  child: const Icon(Icons.clear),
                )
              : null,
          hintText: AppStrings.placeholderSearch,
          filled: true,
          fillColor: AppColors.white,
          prefixIcon: const Icon(CustomIcons.magnify),
        ),
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onChanged: (String value) {
          _debouncer.run(() {
            isEmpty.value = searchController.text.isEmpty;
            if (onChanged != null) {
              onChanged!(value);
            }
          });
        },
      ),
      true.obs,
    );
  }
}
