import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/viewmodels/crypto_viewmodel.dart';
import 'src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => CryptoViewmodel())],
    child: const BNITradeApp(),
  ));
}
