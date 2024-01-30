import 'package:coding_challenge/shared/app_colors.dart';
import 'package:flutter/material.dart';

// THE APP'S THEME DATE.
// To make sure that the all app follows the same guidelines.
//

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
    labelLarge: _labelLarge,
    labelMedium: _labelMedium,
    labelSmall: _labelSmall,
    titleLarge: _titleLarge,
    titleMedium: _titleMedium);

const TextStyle _displayLarge = TextStyle(
  color: AppColors.textColor,
  fontSize: 24,
  fontWeight: FontWeight.w700,
);
const TextStyle _displayMedium = TextStyle(
  color: AppColors.textColor,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);
const TextStyle _displaySmall = TextStyle(
  color: AppColors.textColor,
  fontSize: 17,
  fontWeight: FontWeight.normal,
);
const TextStyle _titleLarge = TextStyle(
  color: AppColors.textColor,
  fontSize: 22,
  fontWeight: FontWeight.w700,
);
const TextStyle _titleMedium = TextStyle(
  color: AppColors.textColor,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);
const TextStyle _bodyLarge = TextStyle(
  color: AppColors.textColor,
  fontSize: 16,
  fontWeight: FontWeight.normal,
  letterSpacing: 0.0,
);
const TextStyle _bodyMedium = TextStyle(
  color: AppColors.textColor,
  fontSize: 15,
  fontWeight: FontWeight.normal,
);
const TextStyle _bodySmall = TextStyle(
  color: AppColors.textColor,
  fontSize: 13,
  fontWeight: FontWeight.normal,
);

const TextStyle _labelSmall = TextStyle(
  color: AppColors.textColor,
  fontSize: 11,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.0,
);

const TextStyle _labelMedium = TextStyle(
  color: AppColors.textColor,
  fontSize: 13,
  fontWeight: FontWeight.normal,
  letterSpacing: 0.0,
);
const TextStyle _labelLarge = TextStyle(
  color: AppColors.textColor,
  fontSize: 16,
  fontWeight: FontWeight.normal,
);
