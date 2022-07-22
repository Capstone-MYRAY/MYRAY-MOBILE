import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/garden/widgets/search_place/search_place_controller.dart';
import 'package:myray_mobile/app/modules/garden/widgets/search_place/search_results.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_icon_button.dart';
import 'package:myray_mobile/app/shared/widgets/controls/search_textfield.dart';

class SearchPlace extends StatelessWidget {
  SearchPlace({Key? key}) : super(key: key);

  final controller = Get.put(SearchPlaceController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              CustomIconButton(
                icon: Icons.chevron_left,
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.black,
                size: 24.0,
                toolTip: 'Trở về',
                padding: const EdgeInsets.all(4.0),
                onTap: () => Get.back(),
              ),
              Expanded(
                child: SearchTextField(
                  searchController: controller.searchController,
                  onChanged: controller.onSearchChange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Obx(
            () => SearchResults(
              suggestions: controller.suggestions,
              isLoading: controller.isLoading.value,
            ),
          ),
        ],
      ),
    );
  }
}
