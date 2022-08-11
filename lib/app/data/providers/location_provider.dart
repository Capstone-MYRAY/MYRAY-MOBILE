import 'package:geolocator/geolocator.dart';

class LocationProvider {
  getUserLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
