import 'package:flutter/material.dart';
import 'package:bni_trading/src/utils/app_colors.dart';
import 'package:bni_trading/src/views/app_tabs.dart';

class BNITradeApp extends StatelessWidget {
  const BNITradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Euclid',
        colorScheme: const ColorScheme.light().copyWith(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
      ),
      home: const AppTabs(),
      debugShowCheckedModeBanner: false,
    );
  }
}
