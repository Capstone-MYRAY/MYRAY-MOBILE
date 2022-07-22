import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/goong_map/goong_map_models.dart';
import 'package:myray_mobile/app/modules/garden/widgets/search_place/search_result_item.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SearchResults extends StatelessWidget {
  final List<PlacesAutocomplete> suggestions;
  final bool isLoading;
  const SearchResults({
    Key? key,
    required this.suggestions,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      ),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return JumpingDotsProgressIndicator(
        fontSize: 40.0,
        color: AppColors.primaryColor,
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: suggestions.length,
      itemBuilder: (_, index) => SearchResultItem(
        mainText: suggestions[index].structuredFormat.mainText,
        address: suggestions[index].address,
        onTap: () {
          Get.back(result: suggestions[index].placeId);
        },
      ),
    );
  }
}
