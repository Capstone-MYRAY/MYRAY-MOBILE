import 'package:geolocator/geolocator.dart';
import 'package:myray_mobile/app/data/providers/location_provider.dart';
import 'package:myray_mobile/app/data/services/services.dart';

class _UserCurrentLocation {
  double? latitude;
  double? longtitude;

  _UserCurrentLocation({this.latitude, this.longtitude});
}

class CurrentLocation {
  CurrentLocation._();

  static final CurrentLocation _instance = CurrentLocation._();
  static CurrentLocation get instance => _instance;
  late Position? _currentPosition;

  _UserCurrentLocation? userCurrentLocation;

  saveUserCurrentLocation() async {
    _currentPosition = await UserLocationService.getGeoLocationPosition();
    if (_currentPosition == null) {
      userCurrentLocation = _UserCurrentLocation(
        latitude: null,
        longtitude: null,
      );
      return;
    }
    userCurrentLocation = _UserCurrentLocation(
      latitude: _currentPosition!.latitude,
      longtitude: _currentPosition!.longitude,
    );
  }
}
