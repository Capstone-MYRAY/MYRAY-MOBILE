import 'package:flutter_config/flutter_config.dart';

class Environment {
  Environment._();

  static String apiUrl = FlutterConfig.get('API_URL');
  static String mapboxPublicKey = FlutterConfig.get('MAP_BOX_PUBLIC_KEY');
}
