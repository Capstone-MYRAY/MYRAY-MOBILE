import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:myray_mobile/app/data/environment.dart';
import 'package:myray_mobile/app/data/services/goong_map_service.dart';
import 'package:myray_mobile/app/data/services/services.dart';
import 'package:myray_mobile/app/modules/garden/widgets/search_place/search_place.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_icon_button.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';

class MyMapView extends StatefulWidget {
  final LatLng currentLocation;
  final LatLng? selectedLocation;
  final String? address;
  const MyMapView({
    Key? key,
    required this.currentLocation,
    this.selectedLocation,
    this.address,
  }) : super(key: key);

  @override
  State<MyMapView> createState() => _MyMapViewState();
}

class _MyMapViewState extends State<MyMapView> {
  final _goongService = Get.find<GoongMapService>();
  MapboxMapController? _controller;
  Symbol? _selectedSymbol;
  late LatLng _currentLocation;
  LatLng? _selectedLocation;
  String? _selectedAddress;

  @override
  void initState() {
    super.initState();

    _currentLocation = widget.currentLocation;
    _selectedLocation = widget.selectedLocation;
    _selectedAddress = widget.address;
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.featureColor,
    ));
  }

  void _onMapCreated(MapboxMapController controller) {
    _controller = controller;
  }

  void _onStyleLoadedCallBack() {
    if (_selectedLocation != null) {
      _addSymbol(AppAssets.marker, _selectedLocation!);
    }

    _setCameraPosition(_selectedLocation ?? _currentLocation);
  }

  void _onMapClick(Point<double> point, LatLng coordinates) {
    _addSymbol(AppAssets.marker, coordinates);
  }

  void _onUserLocationUpdate(UserLocation location) {
    _currentLocation = location.position;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      sized: true,
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Stack(
        children: [
          MapboxMap(
            initialCameraPosition: CameraPosition(
              target: widget.currentLocation,
              zoom: 14.0,
            ),
            accessToken: Environment.mapboxPublicKey,
            onMapCreated: _onMapCreated,
            myLocationRenderMode: MyLocationRenderMode.NORMAL,
            styleString: 'mapbox://styles/ageha-chou/cl5u389mw000316qpgkacj23n',
            myLocationTrackingMode: MyLocationTrackingMode.Tracking,
            doubleClickZoomEnabled: false,
            myLocationEnabled: true,
            onMapClick: _onMapClick,
            onUserLocationUpdated: _onUserLocationUpdate,
            onStyleLoadedCallback: _onStyleLoadedCallBack,
          ),
          _buildBackButtonAndSearch(),
          _buildPositionDisplay(),
        ],
      ),
    );
  }

  Widget _buildBackButtonAndSearch() {
    return Positioned(
      top: 24.0,
      left: 16.0,
      right: 16.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
            elevation: 1.0,
            icon: Icons.chevron_left,
            shape: const CircleBorder(),
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.black,
            size: 24.0,
            toolTip: 'Trở về',
            padding: const EdgeInsets.all(4.0),
            onTap: () => Get.back(),
          ),
          CustomIconButton(
            elevation: 1.0,
            icon: CustomIcons.magnify,
            shape: const CircleBorder(),
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.white,
            size: 24.0,
            toolTip: 'Tìm kiếm',
            padding: const EdgeInsets.all(4.0),
            onTap: _onSearchPlaceCallBack,
          ),
        ],
      ),
    );
  }

  _onSearchPlaceCallBack() async {
    String placeId = await Get.to(() => SearchPlace());
    EasyLoading.show();
    try {
      //get place by id
      final placeDetails = await _goongService.getPlaceDetails(placeId);
      _selectedAddress = placeDetails.address;
      _addSymbol(AppAssets.marker, placeDetails.location);
      //move camera to selected location
      _controller?.animateCamera(CameraUpdate.newLatLng(_selectedLocation!));

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      print('_onSearchPlaceCallBack: ${e.toString()}');
    }
  }

  Widget _buildPositionDisplay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: CustomIconButton(
              icon: Icons.my_location,
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.grey,
              shape: const CircleBorder(),
              size: 22.0,
              padding: const EdgeInsets.all(4.0),
              onTap: () {
                _setCameraPosition(_currentLocation);
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Get.theme.backgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.marker, width: 16.0),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          _selectedAddress ?? '',
                          style: Get.textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                FilledButton(
                  title: 'Chọn địa điểm',
                  onPressed: _selectedSymbol != null ? _onConfirmButton : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onConfirmButton() {
    Get.back(result: {
      Arguments.laLng: _selectedLocation,
      Arguments.address: _selectedAddress,
    });
  }

  void _removeSymbol() {
    if (_selectedSymbol != null) {
      _controller?.removeSymbol(_selectedSymbol!);
      setState(() {
        _selectedSymbol = null;
      });
    }
  }

  _setCameraPosition(LatLng location) {
    _controller?.animateCamera(CameraUpdate.newLatLng(location));
  }

  _addSymbol(String iconImage, LatLng coordinates,
      {bool isBackFromSearch = false}) async {
    _removeSymbol();
    final SymbolOptions options = _getSymbolOptions(iconImage, coordinates);
    final symbol = await _controller?.addSymbol(options);
    _selectedLocation = symbol?.options.geometry!;

    //update address
    if (!isBackFromSearch) {
      _selectedAddress =
          await _goongService.getAddressByLatLng(_selectedLocation!);
    }
    setState(() {
      _selectedSymbol = symbol;
    });
  }

  SymbolOptions _getSymbolOptions(String iconImage, LatLng coordinates) {
    return SymbolOptions(
      geometry: coordinates,
      textField: '',
      iconImage: iconImage,
      iconSize: 2.5,
      iconOffset: const Offset(0, 0.8),
    );
  }
}
