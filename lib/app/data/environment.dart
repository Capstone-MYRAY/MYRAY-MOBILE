import 'package:flutter_config/flutter_config.dart';

class Environment {
  Environment._();

  static String apiUrl = FlutterConfig.get('API_URL');
  static String googleMapsApiKey = FlutterConfig.get('GOOGLE_MAPS_API_KEY');
}
