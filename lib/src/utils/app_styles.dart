import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  AppStyles._();
  static const Widget yGapXs = SizedBox(height: 5.0);
  static const Widget yGapSm = SizedBox(height: 15.0);
  static const Widget yGapMd = SizedBox(height: 35.0);
  static const Widget yGapLg = SizedBox(height: 50.0);
  static TextStyle wBold(double px) {
    return TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: px);
  }

  static TextStyle wRegular(double px) {
    return TextStyle(
        fontWeight: FontWeight.w400, color: Colors.white, fontSize: px);
  }

  static TextStyle primBold(double px) {
    return TextStyle(
        fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: px);
  }

  static TextStyle primLight(double px) {
    return TextStyle(
        fontWeight: FontWeight.w400, color: AppColors.primary, fontSize: px);
  }

  static ButtonStyle btnElevated(Color color) {
    return ElevatedButton.styleFrom(
      minimumSize: const Size(70, 40),
      foregroundColor: Colors.white,
      backgroundColor: color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  static ButtonStyle elevGreenMd = AppStyles.btnElevated(AppColors.primary);
}
