
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myray_mobile/app/data/services/goong_map_service.dart';
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
  final _markerId = 'Location';
  GoogleMapController? _controller;
  late BitmapDescriptor _myIcon;
  final Set<Marker> _markers = {};
  Marker? _selectedMarker;
  late LatLng _currentLocation;
  LatLng? _selectedLocation;
  String? _selectedAddress;

  @override
  void initState() {
    super.initState();

    loadInit();
  }

  loadInit() async {
    _currentLocation = widget.currentLocation;
    _selectedLocation = widget.selectedLocation;
    _selectedAddress = widget.address;
    _myIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(20, 48)), AppAssets.marker);
    if (_selectedLocation != null) {
      _addMarker(_selectedLocation!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.featureColor,
    ));
  }

  void _onMapCreated(GoogleMapController controller) {
    print('create map');
    _controller = controller;
  }

  void _onMapClick(LatLng coordinates) {
    _addMarker(coordinates);
  }

  // void _onUserLocationUpdate(UserLocation location) {
  //   _currentLocation = location.position;
  // }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      sized: true,
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedLocation ?? _currentLocation,
              zoom: 16.0,
            ),
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            onTap: _onMapClick,
            markers: _markers,
            compassEnabled: false,
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
      await _addMarker(placeDetails.location);
      //move camera to selected location
      _setCameraPosition(_selectedLocation!);

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
                  onPressed: _selectedMarker != null ? _onConfirmButton : null,
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

  void _removeMarker() {
    if (_selectedMarker != null) {
      _markers.remove(_selectedMarker);
      setState(() {
        _selectedMarker = null;
      });
    }
  }

  _setCameraPosition(LatLng location) {
    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 16.0),
      ),
    );
  }

  _addMarker(LatLng coordinates, {bool isBackFromSearch = false}) async {
    _removeMarker();
    final Marker marker = _getSymbolOptions(coordinates);
    _markers.add(marker);
    _selectedLocation = marker.position;

    //update address
    if (!isBackFromSearch) {
      _selectedAddress =
          await _goongService.getAddressByLatLng(_selectedLocation!);
    }
    setState(() {
      _selectedMarker = marker;
    });
  }

  Marker _getSymbolOptions(LatLng coordinates) {
    return Marker(
      markerId: MarkerId(_markerId),
      position: coordinates,
      icon: BitmapDescriptor.defaultMarkerWithHue(50),
    );
  }
}
