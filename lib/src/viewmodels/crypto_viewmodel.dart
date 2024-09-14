import 'package:flutter/material.dart';
import 'package:bni_trading/src/models/crypto_price.dart';
import 'package:bni_trading/src/services/crypto_websocket.dart';

class CryptoViewmodel with ChangeNotifier {
  final CryptoWebsocket _cryptoService = CryptoWebsocket();

  CryptoPrice? _cryptoPrice;
  CryptoPrice? get cryptoPrice => _cryptoPrice;

  CryptoPrice? _btcPrice;
  CryptoPrice? _ethPrice;

  CryptoPrice? get btcPrice => _btcPrice;
  CryptoPrice? get ethPrice => _ethPrice;

  CryptoViewmodel() {
    connect();
  }

  void connect() {
    _cryptoService.connect();
    _cryptoService.cryptoPriceStream.listen((price) {
      if (price.tickerCode == 'BTC-USD') {
        _btcPrice = price;
      } else if (price.tickerCode == 'ETH-USD') {
        _ethPrice = price;
      }
      _cryptoPrice = price;
      notifyListeners();
    });
  }

  void subscribe(String message) {
    _cryptoService.subscribe(message);
  }

  void unsubscribe() {
    _cryptoService.unsubscribe();
  }

  @override
  void dispose() {
    unsubscribe();
    super.dispose();
  }
}
