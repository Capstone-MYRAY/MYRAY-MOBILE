import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/area/area.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/data/services/area_repository.dart';
import 'package:myray_mobile/app/data/services/garden_service.dart';
import 'package:myray_mobile/app/modules/garden/controllers/garden_controllers.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class GardenDetailsController extends GetxController with GardenService {
  final _areaRepository = Get.find<AreaRepository>();
  final Rx<Garden> garden;
  final action = Get.arguments[Arguments.action];
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

  onDeleteGarden() async {
    final gardenController = Get.find<GardenHomeController>();
    bool? success = await deleteGarden(garden.value, gardenController.gardens);
    if (success != null && success) {
      Get.back();

      CustomSnackbar.show(
        title: AppStrings.titleSuccess,
        message: AppMsg.MSG4014,
      );
    }
  }
}
