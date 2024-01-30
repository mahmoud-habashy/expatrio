import 'package:coding_challenge/shared/app_colors.dart';
import 'package:coding_challenge/shared/app_constants.dart';
import 'package:flutter/material.dart';

/// A customized secondary button widget without background color.
class SecondaryButton extends StatelessWidget {
  /// The [text] is required argument for the button text.
  /// The [textStyle] is required argument for the text style.
  /// [onPressed] is required argument, the VoidCallback function that gets invoked on every tap.
  /// [icon] is optional argument, if you want to add icon on the left side of the text provide this argument.
  /// [iconColor] is optional argument for icon color, the default value is AppColors.iconColor.
  /// [iconSize] is optional argument for icon size, the default value is AppConstants.defaultIconSize.
  /// 
  final String text;
  final TextStyle textStyle;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final VoidCallback onPressed;
  const SecondaryButton(
      {super.key,
      required this.text,
      required this.textStyle,
      required this.onPressed,
      this.icon,
      this.iconColor = AppColors.iconColor,
      this.iconSize = AppConstants.defaultIconSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          Text(
            text,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
