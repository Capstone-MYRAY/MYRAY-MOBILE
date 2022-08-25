import 'package:logging/logging.dart';
import 'package:myray_mobile/app/data/providers/storage_provider.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'dart:developer' as developer;

class SignalRProvider with StorageProvider {
  SignalRProvider._();
  static final SignalRProvider _instance = SignalRProvider._();
  static SignalRProvider get instance => _instance;

  final String _connectionUrl = 'https://api.myray.site/chathub';

  HubConnection? hubConnection;
  bool isConnectionOpen = false;

  void _getConnection() {
    //get user token
    final String? token = getToken();

    if (token == null) {
      throw CustomException('Unauthorized');
    }

    // Config the logging
    Logger.root.level = Level.ALL;
    // Writes the log messages to the console
    Logger.root.onRecord.listen((LogRecord rec) {
      developer.log('${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    final hubProtLogger = Logger("SignalR - hub");
    final transportProtLogger = Logger("SignalR - transport");

    hubConnection = HubConnectionBuilder()
        .withUrl(
          _connectionUrl,
          options: HttpConnectionOptions(
            accessTokenFactory: () => Future.value(token),
            // logger: transportProtLogger,
            skipNegotiation: true,
            transport: HttpTransportType.WebSockets,
          ),
        )
        // .configureLogging(hubProtLogger)
        // .withAutomaticReconnect()
        .build();
  }

  Future<void> connectToHub() async {
    //get signalR connection
    _getConnection();

    if (hubConnection == null) {
      throw CustomException('Hub not found');
    }

    try {
      await hubConnection!.start();
      isConnectionOpen = true;
      print('Start hub');
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future<void> stopHub() async {
    try {
      await SignalRProvider.instance.hubConnection!.stop();
      isConnectionOpen = false;
      print('Stop hub');
    } catch (e) {
      print('Stop hub error: ${e.toString()}');
    }
  }
}
