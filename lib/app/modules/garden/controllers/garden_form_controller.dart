import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/area/area.dart';
import 'package:myray_mobile/app/data/models/area/get_area_request.dart';
import 'package:myray_mobile/app/data/models/area/get_area_response.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/data/models/garden/post_garden_request.dart';
import 'package:myray_mobile/app/data/models/upload_file/upload_image_response.dart';
import 'package:myray_mobile/app/data/services/area_repository.dart';
import 'package:myray_mobile/app/data/services/upload_image_service.dart';
import 'package:myray_mobile/app/data/services/user_location_service.dart';
import 'package:myray_mobile/app/modules/garden/controllers/garden_home_controller.dart';
import 'package:myray_mobile/app/modules/garden/garden_repository.dart';
import 'package:myray_mobile/app/modules/garden/widgets/upload_image_holder.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class Commune {
  int id;
  String commune;

  Commune({this.id = 0, this.commune = ''});
}

class GardenFormController extends GetxController {
  final _areaRepository = Get.find<AreaRepository>();
  final _uploadImageService = Get.find<UploadImageService>();
  final _gardenRepository = Get.find<GardenRepository>();

  var areas = [].obs;

  var provinces = [].obs;
  var districts = [].obs;
  var communes = [].obs;

  var selectedProvince = ''.obs;
  var selectedDistrict = ''.obs;
  var selectedCommune = Commune().obs;

  late TextEditingController landAreaController;
  late TextEditingController gardenNameController;
  late TextEditingController descriptionController;
  late TextEditingController addressController;
  late GlobalKey<FormState> formKey;
  late GlobalKey<UploadImageHolderState> imageHolderKey;

  Position? _position;

  @override
  void onInit() async {
    landAreaController = TextEditingController();
    gardenNameController = TextEditingController();
    descriptionController = TextEditingController();
    addressController = TextEditingController();
    formKey = GlobalKey<FormState>();
    imageHolderKey = GlobalKey<UploadImageHolderState>();

    await getAreas();
    super.onInit();
  }

  onCreate() async {
    bool formError = !formKey.currentState!.validate();
    bool imageError = !imageHolderKey.currentState!.validate();
    if (formError || imageError) {
      return;
    }

    //show loading
    EasyLoading.show(status: AppStrings.loading);

    //upload image to server
    print('===Upload image');
    final List<UploadImage> _images = imageHolderKey.currentState!.getImages();
    List<MultipartFile> _uploadImages = <MultipartFile>[];
    for (UploadImage image in _images) {
      File imageFile = File(image.path);
      // var stream = imageFile.readAsBytes().asStream();
      // var length = imageFile.lengthSync();
      var fileName = image.path.split('/').last;
      var multipleFile = MultipartFile(imageFile, filename: fileName);
      _uploadImages.add(multipleFile);
    }

    final formData = FormData({'formFiles': _uploadImages});

    print(_uploadImages.length);

    UploadImageResponse? upLoadResponse =
        await _uploadImageService.uploadImage(formData);

    if (upLoadResponse == null) {
      EasyLoading.dismiss();
      //show error
      CustomSnackbar.show(
        title: 'Error',
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
      return;
    }

    //concatenate image_url
    String _imageUrl = '';
    for (int i = 0; i < upLoadResponse.files.length; i++) {
      _imageUrl += upLoadResponse.files[i].link;
      if (i != upLoadResponse.files.length - 1) {
        _imageUrl += CommonConstants.imageDelimiter;
      }
    }

    final int _areaId = selectedCommune.value.id;
    final int _accountId = AuthCredentials.instance.user!.id!;
    final String _gardenName = gardenNameController.text;
    final String _description = descriptionController.text;
    final double _latitude = _position!.latitude;
    final double _longitude = _position!.longitude;
    final double _landArea = double.parse(landAreaController.text);
    final String _address = addressController.text;

    PostGardenRequest data = PostGardenRequest(
      accountId: _accountId,
      address: _address,
      areaId: _areaId,
      description: _description,
      imageUrl: _imageUrl,
      landArea: _landArea,
      latitudes: _latitude,
      longitudes: _longitude,
      name: _gardenName,
    );

    print('===Create garden');
    Garden? newGarden = await _gardenRepository.create(data);
    if (newGarden == null) {
      EasyLoading.dismiss();
      //show error
      CustomSnackbar.show(
        title: 'Lỗi',
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
      return;
    }

    EasyLoading.dismiss();

    //refresh garden list
    final _gardenHomeController = Get.find<GardenHomeController>();
    _gardenHomeController.onRefresh();

    Get.back();
    CustomSnackbar.show(
      title: 'Thành công',
      message: 'Bạn đã thêm vườn thành công',
    );
  }

  getCurrentPosition() async {
    EasyLoading.show(status: AppStrings.loading);
    _position = await UserLocationService.getGeoLocationPosition();
    if (_position == null) {
      EasyLoading.dismiss();
      return;
    }
    print(
        'location: latitude-${_position!.latitude}, longtitude-${_position!.longitude}');
    String address =
        await UserLocationService.getAddressFromLatLong(_position!);
    EasyLoading.dismiss();
    addressController.text = address;
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
    selectedCommune.value = Commune();

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
    selectedCommune.value = Commune();

    loadCommunes();
  }

  loadCommunes() {
    communes.value = [];
    for (Area area in areas) {
      if (Utils.equalsUtf8String(selectedDistrict.value, area.district) &&
          !districts.contains(area.commune)) {
        communes.add(Commune(id: area.id, commune: area.commune));
      }
    }
    districts.sort((a, b) => a.compareTo(b));
  }

  onChangeCommune(value) {
    selectedCommune.value = value;
    gardenNameController.text =
        selectedCommune.value.commune + ' - ' + landAreaController.text;
  }

  String getCommuneString(item) {
    return item.commune;
  }

  bool compareString(s1, s2) {
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

  onChangeLandArea(value) {
    gardenNameController.text =
        selectedCommune.value.commune + ' - ' + landAreaController.text;
  }
}
