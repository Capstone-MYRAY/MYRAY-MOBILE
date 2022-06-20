import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UserLocationService {
  static Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    //test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //request user to enable the location services
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future<String> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: 'vi_VN');
    String? locality;
    for (int i = 0; i < placemarks.length; i++) {
      if (placemarks[i].locality!.isNotEmpty) {
        locality = placemarks[i].locality;
        break;
      }
    }
    Placemark place = placemarks[0];

    if (locality!.isNotEmpty) {
      return '${place.street}, $locality, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
    }

    return '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
  }
}
