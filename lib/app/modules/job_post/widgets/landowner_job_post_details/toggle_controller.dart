import 'package:get/get.dart';

class ToggleController extends GetxController {
  RxBool isOpen = false.obs;

  void toggle() => isOpen.value = !isOpen.value;
}
