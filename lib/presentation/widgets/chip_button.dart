import 'package:coding_challenge/shared/app_colors.dart';
import 'package:coding_challenge/shared/app_constants.dart';
import 'package:flutter/material.dart';

/// A customized rounded button widget with icon.
class ChipButton extends StatelessWidget {
  /// The [text] is required argument for the chip text.
  /// [icon] is required argument it's icon.
  /// [onTap] is required argument, the VoidCallback function that gets invoked on every tap.  .
  /// [backgroundColor] is optional argument, the default value is AppColors.background.
  /// [contentColor] is optional argument for content color, the default value is AppColors.primary.
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color contentColor;
  final VoidCallback onTap;
  const ChipButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.icon,
      this.backgroundColor = AppColors.background,
      this.contentColor = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: AppConstants.paddingElement * 4,
            horizontal: AppConstants.paddingElement * 7),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppConstants.defaultRadius),
                  border: Border.all(
                      width: AppConstants.borderElement, color: contentColor)),
              child: Icon(
                icon,
                size: AppConstants.iconSize * 4,
                color: contentColor,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: AppConstants.paddingElement * 2),
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: contentColor, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
