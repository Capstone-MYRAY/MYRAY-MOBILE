import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/garden/widgets/garden_card.dart';

class GardenHomeController extends GetxController {
  List<GardenCard> gardens = const [
    GardenCard(),
    GardenCard(),
    GardenCard(),
    GardenCard(),
  ].obs;

  final loadingState = false.obs;

  Future<void> addMore() async {
    loadingState.value = true;
    await Future.delayed(const Duration(seconds: 2));

    gardens.addAll([
      const GardenCard(),
    ]);

    loadingState.value = false;
  }
}
