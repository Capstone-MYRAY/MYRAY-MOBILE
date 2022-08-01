import 'package:flutter_config/flutter_config.dart';

class Environment {
  Environment._();

  static String apiUrl = FlutterConfig.get('API_URL');
  static String googleMapApiKey = FlutterConfig.get('GOOGLE_MAPS_API_KEY');
  static String goongMapUrl = FlutterConfig.get('GOONG_MAP_URL');
  static String goongMapApiKey = FlutterConfig.get('GOONG_API_KEY');
  static String mapboxPublicKey = FlutterConfig.get('MAP_BOX_PUBLIC_KEY');
}
