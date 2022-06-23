import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:myray_mobile/app/data/environment.dart';
import 'package:myray_mobile/app/data/services/user_location_service.dart';

import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/custom_icon_button.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class SearchPlacesView extends StatefulWidget {
  SearchPlacesView({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<SearchPlacesView> createState() => _SearchPlacesViewState();
}

class _SearchPlacesViewState extends State<SearchPlacesView> {
  final Set<Marker> _markers = {};
  final Mode _mode = Mode.overlay;

  CameraPosition _initialCameraPosition =
      const CameraPosition(target: LatLng(10.762622, 106.660172), zoom: 14.0);
  late GoogleMapController _ggController;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Position _position = await UserLocationService.getGeoLocationPosition();
    _initialCameraPosition = CameraPosition(
        target: LatLng(_position.latitude, _position.longitude), zoom: 14.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        actions: [
          CustomIconButton(
            icon: CustomIcons.magnify,
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.white,
            toolTip: 'Tìm vị trí',
            onTap: _handlePressButton,
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            markers: _markers,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _ggController = controller;
            },
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          ),
        ],
      ),
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: Environment.googleMapsApiKey,
        onError: _onError,
        mode: _mode,
        language: 'vi',
        strictbounds: false,
        types: [''],
        decoration: const InputDecoration(
          hintText: 'Tìm kiếm',
        ),
        components: [Component(Component.country, 'vi')]);
    _displayPrediction(p!, widget.scaffoldKey.currentState);
  }

  Future<void> _displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: Environment.googleMapsApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse details =
        await places.getDetailsByPlaceId(p.placeId!);

    final lat = details.result.geometry!.location.lat;
    final lng = details.result.geometry!.location.lng;
    final position = LatLng(lat, lng);

    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId("0"),
        position: position,
        infoWindow: InfoWindow(title: details.result.name),
      ),
    );
    print(_markers.toString());
    setState(() {});

    _ggController.animateCamera(CameraUpdate.newLatLngZoom(position, 14.0));
  }

  void _onError(PlacesAutocompleteResponse response) {
    print(response.errorMessage);
    CustomSnackbar.show(
      title: AppStrings.titleError,
      message: 'Có lỗi xảy ra',
      backgroundColor: AppColors.errorColor,
    );
  }
}
