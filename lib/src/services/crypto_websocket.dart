import 'dart:convert';
import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:bni_trading/src/models/crypto_price.dart';

class CryptoWebsocket {
  static final CryptoWebsocket _instance = CryptoWebsocket._internal();
  CryptoWebsocket._internal();

  factory CryptoWebsocket() {
    return _instance;
  }
  final String url = 'wss://ws.eodhistoricaldata.com/ws/crypto?api_token=demo';
  WebSocketChannel? _channel;

  void connect() {
    _channel ??= WebSocketChannel.connect(Uri.parse(url)); // if its null
  }

  // Stream listen message
  Stream<CryptoPrice> get cryptoPriceStream {
    return _channel!.stream.map((msg) {
      final parsed = json.decode(msg);
      if (parsed is Map<String, dynamic>) {
        return CryptoPrice.fromJson(parsed);
      } else {
        throw Exception("Invalid message format");
      }
    });
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
