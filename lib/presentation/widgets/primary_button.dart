import 'package:coding_challenge/shared/app_colors.dart';
import 'package:coding_challenge/shared/app_constants.dart';
import 'package:flutter/material.dart';

/// A customized primary rounded button widget.
class PrimaryButton extends StatelessWidget {
  /// The [text] is required argument for the chip text.
  /// [onPressed] is required argument, the VoidCallback function that gets invoked on every tap.
  /// [fillColor] is optional argument, the default value is AppColors.primary.
  /// [textColor] is optional argument for text color, the default value is AppColors.white.
  ///
  final String text;
  final VoidCallback onPressed;
  final Color fillColor;
  final Color textColor;
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fillColor = AppColors.primary,
    this.textColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                vertical: AppConstants.paddingElement * 5),
            backgroundColor: fillColor,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppConstants.radiusElement * 6))),
        child: Text(
          text,
          style:
              Theme.of(context).textTheme.bodySmall!.copyWith(color: textColor),
        ));
  }
}
