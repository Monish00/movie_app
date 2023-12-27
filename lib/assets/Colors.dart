import 'package:flutter/material.dart';

class AppColor {
  static Color componentColor = const Color(0xFFFFB992);
  static Color backgroundColor = const Color(0xFFF9E5DA);
  static Color lightText = const Color(0xFF000000);
  static ColorScheme appTheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColor.componentColor,
    onPrimary: AppColor.componentColor,
    secondary: AppColor.componentColor,
    onSecondary: AppColor.componentColor,
    error: Colors.red,
    onError: Colors.red,
    background: AppColor.backgroundColor,
    onBackground: AppColor.backgroundColor,
    surface: Colors.white,
    onSurface: Colors.white,
  );
}
