import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
import 'package:myray_mobile/app/modules/garden/controllers/garden_details_controller.dart';
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

  GardenDetailsController? detailsController;

  LatLng? _latLng;

  final Activities action = Get.arguments[Arguments.action];

  String get screenTitle => action == Activities.create
      ? AppStrings.titleCreateGarden
      : AppStrings.titleEditGarden;

  String get buttonTitle => action == Activities.create
      ? AppStrings.titleCreate
      : AppStrings.titleUpdate;

  @override
  void onInit() async {
    landAreaController = TextEditingController();
    gardenNameController = TextEditingController();
    descriptionController = TextEditingController();
    addressController = TextEditingController();
    formKey = GlobalKey<FormState>();
    imageHolderKey = GlobalKey<UploadImageHolderState>();

    await getAreas();

    //load value if action is update
    if (action == Activities.update) {
      //get details controller
      detailsController =
          Get.find<GardenDetailsController>(tag: Get.arguments[Arguments.tag]);

      //load area
      Area _area = detailsController!.area!.value;
      Garden garden = detailsController!.garden.value;
      selectedProvince.value = _area.province;
      selectedDistrict.value = _area.district;
      selectedCommune.value = Commune(id: _area.id, commune: _area.commune);

      landAreaController.text = garden.landArea.toString();
      gardenNameController.text = garden.name;
      descriptionController.text = garden.description;
      addressController.text = garden.address;
      _latLng = LatLng(
        garden.latitudes,
        garden.longitudes,
      );

      //generate images list
      List<String> imageStr =
          garden.imageUrl.split(CommonConstants.imageDelimiter);
      List<UploadImage> images = [];
      for (String str in imageStr) {
        int id = images.length + 1;
        images.add(UploadImage(id: id, path: str));
      }

      //set images
      imageHolderKey.currentState!.setImages(images);
    }

    super.onInit();
  }

  onSubmit() async {
    bool formError = !formKey.currentState!.validate();
    bool imageError = !imageHolderKey.currentState!.validate();
    if (formError || imageError) {
      return;
    }

    if (action == Activities.create) {
      await onCreate();
    } else {
      await onUpdate();
    }
  }

  List<MultipartFile> generateMultipart(List<UploadImage> images) {
    List<MultipartFile> _uploadImages = <MultipartFile>[];
    for (UploadImage image in images) {
      if (!Utils.isNetworkImage(image.path)) {
        File imageFile = File(image.path);
        var fileName = image.path.split('/').last;
        var multipleFile = MultipartFile(imageFile, filename: fileName);
        _uploadImages.add(multipleFile);
      }
    }
    return _uploadImages;
  }

  onUpdate() async {
    //show loading
    EasyLoading.show(status: AppStrings.loading);

    // delete image from server
    await _uploadImageService
        .deleteImages(imageHolderKey.currentState!.deleteImages);

    //upload new image
    final List<UploadImage> _images =
        imageHolderKey.currentState!.selectedImages;
    List<MultipartFile> _uploadImages = generateMultipart(_images);
    UploadImageResponse? upLoadResponse;
    String _imageUrl = '';
    if (_uploadImages.isNotEmpty) {
      upLoadResponse = await _uploadImageService.uploadImage(_uploadImages);

      if (upLoadResponse == null) {
        EasyLoading.dismiss();
        //show error
        CustomSnackbar.show(
          title: AppStrings.titleError,
          message: 'Có lỗi xảy ra',
          backgroundColor: AppColors.errorColor,
        );
        return;
      }

      int count = 0;
      //merge uploaded images with old images
      for (int i = 0; i < _images.length; i++) {
        if (!Utils.isNetworkImage(_images[i].path)) {
          _images[i].path = upLoadResponse.files[count].link;
          count++;
        }
      }
    }

    //concatenate uploaded image_url
    for (int i = 0; i < _images.length; i++) {
      _imageUrl += _images[i].path;
      if (i < _images.length - 1) {
        _imageUrl += CommonConstants.imageDelimiter;
      }
    }

    //update garden
    final int _areaId = selectedCommune.value.id;
    final String _gardenName = gardenNameController.text;
    final String _description = descriptionController.text;
    final double _latitude = _latLng!.latitude;
    final double _longitude = _latLng!.longitude;
    final double _landArea = double.parse(landAreaController.text);
    final String _address = addressController.text;

    Garden data = detailsController!.garden.value
      ..areaId = _areaId
      ..name = _gardenName
      ..description = _description
      ..latitudes = _latitude
      ..longitudes = _longitude
      ..landArea = _landArea
      ..address = _address
      ..imageUrl = _imageUrl;

    Garden? updatedGarden = await _gardenRepository.update(data);
    if (updatedGarden == null) {
      EasyLoading.dismiss();
      //show error
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
      return;
    }

    EasyLoading.dismiss();

    //refresh garden
    detailsController!.garden.value = updatedGarden;

    //update garden list
    final GardenHomeController _gardenHome = Get.find<GardenHomeController>();
    final _gardens = _gardenHome.gardens;
    int index = _gardens.indexWhere(
        (garden) => garden.id == detailsController!.garden.value.id);
    detailsController!.garden.value = updatedGarden;
    _gardens[index] = updatedGarden;
    Get.back();
    CustomSnackbar.show(
      title: AppStrings.titleSuccess,
      message: 'Cập nhật thành công',
    );
  }

  onCreate() async {
    //show loading
    EasyLoading.show(status: AppStrings.loading);

    //upload image to server
    print('===Upload image');
    final List<UploadImage> _images =
        imageHolderKey.currentState!.selectedImages;
    List<MultipartFile> _uploadImages = generateMultipart(_images);

    UploadImageResponse? upLoadResponse =
        await _uploadImageService.uploadImage(_uploadImages);

    if (upLoadResponse == null) {
      EasyLoading.dismiss();
      //show error
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
      return;
    }

    //concatenate image_url
    String _imageUrl = '';
    for (int i = 0; i < upLoadResponse.files.length; i++) {
      _imageUrl += upLoadResponse.files[i].link;
      if (i < upLoadResponse.files.length - 1) {
        _imageUrl += CommonConstants.imageDelimiter;
      }
    }

    final int _areaId = selectedCommune.value.id;
    final int _accountId = AuthCredentials.instance.user!.id!;
    final String _gardenName = gardenNameController.text;
    final String _description = descriptionController.text;
    final double _latitude = _latLng!.latitude;
    final double _longitude = _latLng!.longitude;
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
        title: AppStrings.titleError,
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
      title: AppStrings.titleSuccess,
      message: 'Bạn đã thêm vườn thành công',
    );
  }

  getCurrentPosition() async {
    EasyLoading.show(status: AppStrings.loading);
    Position _position = await UserLocationService.getGeoLocationPosition();

    _latLng = LatLng(_position.latitude, _position.longitude);

    print(
        'location: latitude-${_position.latitude}, longtitude-${_position.longitude}');
    String address = await UserLocationService.getAddressFromLatLong(_position);
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
    setGardenName();
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
    setGardenName();
  }

  setGardenName() {
    if (action == Activities.create) {
      gardenNameController.text =
          selectedCommune.value.commune + ' - ' + landAreaController.text;
    }
  }
}
