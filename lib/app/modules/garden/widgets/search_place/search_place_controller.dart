import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/goong_map/goong_map_models.dart';
import 'package:myray_mobile/app/data/services/goong_map_service.dart';

class SearchPlaceController extends GetxController {
  final List<PlacesAutocomplete> suggestions = [];
  final _goongService = Get.find<GoongMapService>();
  final searchController = TextEditingController();
  var isLoading = false.obs;

  onSearchChange(String value) {
    isLoading.value = true;
    if (searchController.text.isEmpty) return;
    _getSuggestion().then((value) => isLoading.value = false);
  }

  Future<void> _getSuggestion() async {
    final data = AutocompleteRequest(input: searchController.text);
    List<PlacesAutocomplete>? tempList = await _goongService.autocomplete(data);
    suggestions.clear();
    if (tempList != null) {
      suggestions.addAll(tempList);
    }
  }
}
