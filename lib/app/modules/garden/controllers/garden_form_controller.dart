import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/area/area.dart';
import 'package:myray_mobile/app/data/models/area/get_area_request.dart';
import 'package:myray_mobile/app/data/models/area/get_area_response.dart';
import 'package:myray_mobile/app/data/services/area_repository.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class _Commune {
  int id;
  String commune;

  _Commune({this.id = 0, this.commune = ''});
}

class GardenFormController extends GetxController {
  final _areaRepository = Get.find<AreaRepository>();

  var areas = [].obs;

  var provinces = [].obs;
  var districts = [].obs;
  var communes = [].obs;

  var selectedProvince = ''.obs;
  var selectedDistrict = ''.obs;
  var selectedCommune = _Commune().obs;

  late TextEditingController landAreaController;
  late TextEditingController gardenNameController;
  late TextEditingController descriptionController;

  @override
  void onInit() async {
    super.onInit();
    landAreaController = TextEditingController();
    gardenNameController = TextEditingController();
    descriptionController = TextEditingController();

    await getAreas();
  }

  Future<void> getAreas() async {
    GetAreaRequest data = GetAreaRequest(
      page: '1',
      pageSize: '100',
      status: '1',
      sortColumn: AreaSortColumn.province,
      orderBy: SortOrder.ascending,
    );

    final GetAreaResponse? response = await _areaRepository.getAreas(data);
    if (response == null) return;

    if (response.areas != null) {
      areas.value = response.areas as List<Area>;
      loadProvinces();
    }
  }

  loadProvinces() {
    for (Area area in areas) {
      if (!provinces.contains(area.province)) {
        provinces.add(area.province);
      }
    }
  }

  onChangeProvince(value) {
    selectedProvince.value = value;

    //reset district and commune
    selectedDistrict.value = '';
    selectedCommune.value = _Commune();

    loadDistricts();
  }

  loadDistricts() {
    districts.value = [];
    for (Area area in areas) {
      if (Utils.equalsUtf8String(selectedProvince.value, area.province) &&
          !districts.contains(area.district)) {
        districts.add(area.district);
      }
    }
    districts.sort((a, b) => a.compareTo(b));
  }

  onChangeDistrict(value) {
    selectedDistrict.value = value;

    //reset commune
    selectedCommune.value = _Commune();

    loadCommunes();
  }

  loadCommunes() {
    communes.value = [];
    for (Area area in areas) {
      if (Utils.equalsUtf8String(selectedDistrict.value, area.district) &&
          !districts.contains(area.commune)) {
        communes.add(_Commune(id: area.id, commune: area.commune));
      }
    }
    districts.sort((a, b) => a.compareTo(b));
  }

  onChangeCommune(value) {
    selectedCommune.value = value;
  }

  String getCommuneString(item) {
    return item.commune;
  }

  bool compareString(s1, s2) {
    print('compare');
    if (s1 != null && s2 != null) {
      return Utils.equalsUtf8String(s1.toString(), s2.toString());
    }
    return false;
  }

  bool compareCommune(s1, s2) {
    if (s1 != null && s2 != null) {
      return s1.id == s2.id;
    }
    return false;
  }
}
