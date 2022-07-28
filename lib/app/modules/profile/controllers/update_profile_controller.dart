import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class UpdateProfileController extends GetxController {
  final Account user = Get.arguments[Arguments.item];
  final ImagePicker _picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  late ImageProvider profileImage;
  final fullNameController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  Rx<File?> currentImage = Rx(null);
  RxInt selectedGender = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  _loadData() {
    if (user.imageUrl == null) {
      profileImage = const AssetImage(AppAssets.tempAvatar);
    } else {
      profileImage = NetworkImage(user.imageUrl!);
    }

    fullNameController.text = user.fullName ?? '';
    dobController.text =
        user.dob == null ? '' : Utils.formatddMMyyyy(user.dob!);
    emailController.text = user.email ?? '';
    addressController.text = user.address ?? '';
    descriptionController.text = user.aboutMe ?? '';
    selectedGender.value = user.gender ?? 0;
  }

  showImageDialog() async {
    XFile? selectedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );

    if (selectedImage != null) {
      currentImage.value = File(selectedImage.path);
    }
  }

  clearCurrentImage() {
    currentImage.value = null;
  }
}
