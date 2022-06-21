import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/area/area.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/data/services/area_repository.dart';

class GardenDetailsController extends GetxController {
  final _areaRepository = Get.find<AreaRepository>();
  final Rx<Garden> garden;
  Rx<Area>? area;

  GardenDetailsController({required this.garden});

  Future<Area?> getArea() async {
    return _areaRepository.getAreaById(garden.value.areaId);
  }
}
