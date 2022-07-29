import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/profile/update_profile_request.dart';
import 'package:myray_mobile/app/data/services/services.dart';
import 'package:myray_mobile/app/modules/profile/controllers/farmer_profile_controller.dart';
import 'package:myray_mobile/app/modules/profile/controllers/landowner_profile_controller.dart';
import 'package:myray_mobile/app/modules/profile/profile_repository.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/controls/my_date_picker.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class UpdateProfileController extends GetxController {
  final _profileRepository = Get.find<ProfileRepository>();
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
  late DateTime dob;

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
    dob = user.dob!.toLocal();
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

  onChooseDob() async {
    DateTime? selectedDate = await MyDatePicker.show(initDate: dob);

    if (selectedDate != null) {
      dob = selectedDate;
      dobController.text = Utils.formatddMMyyyy(selectedDate);
    }
  }

  updateProfile() async {
    if (!formKey.currentState!.validate()) return;

    String? imgUrl = user.imageUrl;

    try {
      EasyLoading.show();
      if (currentImage.value != null) {
        //update image
        final uploadService = Get.find<UploadImageService>();
        final multipart = MultipartFile(currentImage.value,
            filename: currentImage.value!.path.split("/").last);
        final uploadedImage = await uploadService.uploadImage([multipart]);
        if (uploadedImage != null) {
          imgUrl = uploadedImage.files.first.link;
        }
      }

      final data = UpdateProfileRequest(
        id: user.id!,
        roleId: user.roleId!,
        fullName: fullNameController.text.trim(),
        dob: dob,
        gender: selectedGender.value,
        phone: user.phoneNumber!,
        address: addressController.text.isEmpty ? null : addressController.text,
        aboutMe: descriptionController.text.isEmpty
            ? null
            : descriptionController.text,
        email: emailController.text.isEmpty ? null : emailController.text,
        avatar: imgUrl,
      );

      final updatedAccount = await _profileRepository.updateProfile(data);

      if (updatedAccount != null) {
        if (user.roleId == CommonConstants.landownerRoleId) {
          final profile = Get.find<LandownerProfileController>();
          profile.user.value = updatedAccount;
          profile.user.refresh();
        } else {
          final profile = Get.find<FarmerProfileController>();
          profile.user.value = updatedAccount;
          profile.user.refresh();
        }
      }

      Get.back();
      CustomSnackbar.show(
        title: AppStrings.titleSuccess,
        message: 'Cập nhật hồ sơ thành công',
      );

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }
}
