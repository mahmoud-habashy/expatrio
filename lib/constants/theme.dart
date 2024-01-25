import 'package:coding_challenge/constants/colors.dart';
import 'package:coding_challenge/constants/doubles.dart';
import 'package:flutter/material.dart';

ThemeData expatrioThemeData = ThemeData(
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  canvasColor: Colors.transparent,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.primary,
    selectionColor: AppColors.primary,
    selectionHandleColor: AppColors.primary,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSwatch(
          primarySwatch: createMaterialColor(AppColors.white))
      .copyWith(
    secondary: createMaterialColor(AppColors.primary),
  ),
  primaryColorDark: AppColors.white,
  textTheme: _expatrioTextTheme,
);

TextTheme _expatrioTextTheme = const TextTheme(
  displayLarge: _displayLarge,
  displayMedium: _displayMedium,
  displaySmall: _displaySmall,
  bodyLarge: _bodyLarge,
  bodyMedium: _bodyMedium,
  bodySmall: _bodySmall,
);

const TextStyle _displayLarge = TextStyle(
  color: AppColors.textColor,
  fontSize: 22,
  fontWeight: FontWeight.w700,
);
const TextStyle _displayMedium = TextStyle(
  color: AppColors.textColor,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);
const TextStyle _displaySmall = TextStyle(
  color: AppColors.textColor,
  fontSize: 16,
  fontWeight: FontWeight.w700,
);

const TextStyle _bodyLarge = TextStyle(
  color: AppColors.textColor,
  fontSize: 16,
  height: AppDoubles.textLineHeight * 3,
  fontWeight: FontWeight.normal,
);
const TextStyle _bodyMedium = TextStyle(
  color: AppColors.textColor,
  fontSize: 15,
  fontWeight: FontWeight.normal,
);
const TextStyle _bodySmall = TextStyle(
  color: AppColors.textColor,
  fontSize: 10,
  fontWeight: FontWeight.w300,
);
