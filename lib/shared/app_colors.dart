import 'package:flutter/material.dart';

// THE APP'S COLOR PALETTE.
class AppColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF42AEA0);
  static const Color accent = Color.fromARGB(255, 246, 66, 53);
  static const Color textColor = Color(0xFF262626);
  static const Color grey = Color(0xFF3B3B3A);
  static const Color lightGrey = Color(0xFFA8A8A8);
  static const Color green = Color(0xFF4CAF50);
  static const Color iconColor = Color(0xFF262626);
  static const Color appBarLeadingIconColor = Color(0xFF000000);
  static const Color shadowColor = Color(0xFFFAFAFA);
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
