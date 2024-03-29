import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_icon_button.dart';

import './search_textfield.dart';

class SearchAndFilter extends StatelessWidget {
  final TextEditingController searchController;
  final void Function() onFilterTap;
  final void Function(String)? onTextChanged;
  final bool refreshOnClear;

  const SearchAndFilter({
    Key? key,
    required this.onFilterTap,
    required this.searchController,
    this.onTextChanged,
    this.refreshOnClear = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      width: Get.width * 0.9,
      child: SizedBox(
        height: 50,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SearchTextField(
                  onChanged: onTextChanged,
                  searchController: searchController,
                  refreshOnClear: refreshOnClear,
                ),
              ),
              const SizedBox(width: 16.0),
              CustomIconButton(
                onTap: onFilterTap,
                icon: CustomIcons.filter,
                foregroundColor: AppColors.white,
                backgroundColor: AppColors.primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                size: 24.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius:
                      BorderRadius.circular(CommonConstants.borderRadius),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
