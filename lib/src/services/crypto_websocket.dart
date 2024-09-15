import 'dart:convert';
import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:bni_trading/src/models/crypto_price.dart';

class CryptoWebsocket {
  // create singleton-pattern
  static final CryptoWebsocket _instance = CryptoWebsocket._internal();
  CryptoWebsocket._internal();

  factory CryptoWebsocket() {
    return _instance;
  }
  final String url = 'wss://ws.eodhistoricaldata.com/ws/crypto?api_token=demo';
  WebSocketChannel? _channel;
  DateTime? _lastEmissionTime;

  void connect() {
    _channel ??= WebSocketChannel.connect(Uri.parse(url));
  }

  // Stream listen message
  Stream<CryptoPrice> get cryptoPriceStream async* {
    _lastEmissionTime = DateTime.now().subtract(const Duration(seconds: 1));
    await for (var msg in _channel!.stream) {
      final parsed = json.decode(msg);
      if (parsed is Map<String, dynamic>) {
        CryptoPrice data = CryptoPrice.fromJson(parsed);
        // emit data only if at least 1 second passed
        DateTime now = DateTime.now();
        if (_lastEmissionTime == null ||
            now.difference(_lastEmissionTime!).inSeconds >= 1) {
          _lastEmissionTime = now;
          yield data; // emit the data (price)
        }
      } else {
        throw Exception("Invalid message stream");
      }
    }
  }

  void subscribe(String message) {
    if (_channel != null) {
      _channel!.sink.add(message);
    }
  }

  void unsubscribe() {
    _channel?.sink.close(status.goingAway);
    _channel = null;
  }
}
