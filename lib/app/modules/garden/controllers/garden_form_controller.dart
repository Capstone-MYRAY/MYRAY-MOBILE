import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/area/area_models.dart';
import 'package:myray_mobile/app/data/models/garden/garden_models.dart';
import 'package:myray_mobile/app/data/models/upload_file/upload_file_models.dart';
import 'package:myray_mobile/app/data/services/services.dart';
import 'package:myray_mobile/app/modules/garden/controllers/garden_controllers.dart';
import 'package:myray_mobile/app/modules/garden/garden_repository.dart';
import 'package:myray_mobile/app/modules/garden/widgets/upload_image_holder.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/modules/garden/views/my_map_view.dart';

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

  double latitude = 91;
  double longitude = 181;

  late TextEditingController landAreaController;
  late TextEditingController gardenNameController;
  late TextEditingController descriptionController;
  late TextEditingController addressController;
  late GlobalKey<FormState> formKey;
  late GlobalKey<UploadImageHolderState> imageHolderKey;

  GardenDetailsController? detailsController;

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
      Area area = detailsController!.area!.value;
      Garden garden = detailsController!.garden.value;
      selectedProvince.value = area.province;
      selectedDistrict.value = area.district;
      selectedCommune.value = Commune(id: area.id, commune: area.commune);

      landAreaController.text = garden.landArea.toString();
      gardenNameController.text = garden.name.trim();
      descriptionController.text = garden.description.trim();
      addressController.text = garden.address.trim();
      latitude = garden.latitudes;
      longitude = garden.longitudes;

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
    List<MultipartFile> uploadImages = <MultipartFile>[];
    for (UploadImage image in images) {
      if (!Utils.isNetworkImage(image.path)) {
        File imageFile = File(image.path);
        var fileName = image.path.split('/').last;
        var multipleFile = MultipartFile(imageFile, filename: fileName);
        uploadImages.add(multipleFile);
      }
    }
    return uploadImages;
  }

  onUpdate() async {
    //show loading
    EasyLoading.show(status: AppStrings.loading);

    // delete image from server
    await _uploadImageService
        .deleteImages(imageHolderKey.currentState!.deleteImages);

    //upload new image
    final List<UploadImage> images =
        imageHolderKey.currentState!.selectedImages;
    List<MultipartFile> uploadImages = generateMultipart(images);
    UploadImageResponse? upLoadResponse;
    String imageUrl = '';
    if (uploadImages.isNotEmpty) {
      upLoadResponse = await _uploadImageService.uploadImage(uploadImages);

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
      for (int i = 0; i < images.length; i++) {
        if (!Utils.isNetworkImage(images[i].path)) {
          images[i].path = upLoadResponse.files[count].link;
          count++;
        }
      }
    }

    //concatenate uploaded image_url
    for (int i = 0; i < images.length; i++) {
      imageUrl += images[i].path;
      if (i < images.length - 1) {
        imageUrl += CommonConstants.imageDelimiter;
      }
    }

    //update garden
    final int areaId = selectedCommune.value.id;
    final String gardenName = gardenNameController.text.trim();
    final String description = descriptionController.text.trim();
    final double landArea = double.parse(landAreaController.text);
    final String address = addressController.text.trim();

    Garden data = detailsController!.garden.value
      ..areaId = areaId
      ..name = gardenName
      ..description = description
      ..latitudes = latitude
      ..longitudes = longitude
      ..landArea = landArea
      ..address = address
      ..imageUrl = imageUrl;

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
    final GardenHomeController gardenHome = Get.find<GardenHomeController>();
    final gardens = gardenHome.gardens;
    int index = gardens.indexWhere(
        (garden) => garden.id == detailsController!.garden.value.id);
    detailsController!.garden.value = updatedGarden;
    gardens[index] = updatedGarden;
    Get.back();
    CustomSnackbar.show(
      title: AppStrings.titleSuccess,
      message: AppMsg.MSG4012,
    );
  }

  onCreate() async {
    //show loading
    EasyLoading.show(status: AppStrings.loading);

    //upload image to server
    print('===Upload image');
    final List<UploadImage> images =
        imageHolderKey.currentState!.selectedImages;
    List<MultipartFile> uploadImages = generateMultipart(images);

    UploadImageResponse? upLoadResponse =
        await _uploadImageService.uploadImage(uploadImages);

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
    String imageUrl = '';
    for (int i = 0; i < upLoadResponse.files.length; i++) {
      imageUrl += upLoadResponse.files[i].link;
      if (i < upLoadResponse.files.length - 1) {
        imageUrl += CommonConstants.imageDelimiter;
      }
    }

    final int areaId = selectedCommune.value.id;
    final int accountId = AuthCredentials.instance.user!.id!;
    final String gardenName = gardenNameController.text;
    final String description = descriptionController.text;
    final double landArea = double.parse(landAreaController.text);
    final String address = addressController.text;

    PostGardenRequest data = PostGardenRequest(
      accountId: accountId,
      address: address,
      areaId: areaId,
      description: description,
      imageUrl: imageUrl,
      landArea: landArea,
      latitudes: latitude,
      longitudes: longitude,
      name: gardenName,
    );

    print(data.toJson());

    print('===Create garden');
    try {
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
      final gardenHomeController = Get.find<GardenHomeController>();
      gardenHomeController.onRefresh();

      Get.back();
      CustomSnackbar.show(
        title: AppStrings.titleSuccess,
        message: AppMsg.MSG4011,
      );
    } catch (e) {
      EasyLoading.dismiss();
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
      print('Create error: ${e.toString()}');
    }
  }

  getCurrentPosition() async {
    try {
      EasyLoading.show(status: AppStrings.loading);
      Position position = await UserLocationService.getGeoLocationPosition();

      print(
          'location: latitude-${position.latitude}, longtitude-${position.longitude}');
      String address =
          await UserLocationService.getAddressFromLatLong(position);
      EasyLoading.dismiss();
      addressController.text = address;
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      EasyLoading.dismiss();
      print('Get position error: ${e.toString()}');
    }
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
          '${selectedCommune.value.commune} - ${landAreaController.text}';
    }
  }

  bool get latitudeRange => latitude >= -90 && latitude <= 90;
  bool get longitudeRange => longitude >= -180 && longitude < 180;

  navigateToMap() async {
    LatLng? selectedLocation;

    if (latitudeRange && longitudeRange) {
      selectedLocation = LatLng(latitude, longitude);
    }

    try {
      EasyLoading.show();
      Position location = await UserLocationService.getGeoLocationPosition();
      EasyLoading.dismiss();
      final result = await Get.to(
        () => MyMapView(
          currentLocation: LatLng(
            location.latitude,
            location.longitude,
          ),
          selectedLocation: selectedLocation,
          address:
              addressController.text.isEmpty ? null : addressController.text,
        ),
      );

      if (result != null) {
        addressController.text = result[Arguments.address] as String;

        latitude = (result[Arguments.laLng] as LatLng).latitude;
        longitude = (result[Arguments.laLng] as LatLng).longitude;
      }
    } catch (e) {
      EasyLoading.dismiss();
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
      print('GardenForm-navigateToMap: ${e.toString()}');
    }
  }
}
