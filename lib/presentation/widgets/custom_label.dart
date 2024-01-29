import 'package:coding_challenge/shared/app_colors.dart';
import 'package:coding_challenge/shared/app_constants.dart';
import 'package:flutter/material.dart';

/// A customized label widget for [TextFormField].
class CustomLabel extends StatelessWidget {
  /// The [text] is required argument for the text.
  /// The [textStyle] is required argument for the text style.
  /// [icon] is optional argument, if you want to add icon on the left side of the text provide this argument.
  /// [iconColor] is optional argument for icon color, the default value is AppColors.iconColor.
  /// [iconSize] is optional argument for icon size, the default value is AppConstants.defaultIconSize.
  final String text;
  final TextStyle textStyle;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  const CustomLabel(
      {super.key,
      required this.text,
      required this.textStyle,
      this.icon,
      this.iconColor = AppColors.iconColor,
      this.iconSize = AppConstants.defaultIconSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Container(
            margin: const EdgeInsets.only(left: AppConstants.marginElement),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
        Expanded(
          child: Text(
            text,
            style: textStyle,
          ),
        )
      ],
    );
  }
}
