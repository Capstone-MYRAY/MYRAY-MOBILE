import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/area/area.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/data/services/area_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';

class GardenDetailsController extends GetxController {
  final _areaRepository = Get.find<AreaRepository>();
  final Rx<Garden> garden;
  Rx<Area>? area;

  GardenDetailsController({required this.garden});

  Future<Area?> getArea() async {
    return _areaRepository.getAreaById(garden.value.areaId);
  }

  navigateToEditForm() {
    Get.toNamed(Routes.gardenForm, arguments: {
      Arguments.action: Activities.update,
      Arguments.tag: Get.arguments[Arguments.tag],
    });
  }
}
