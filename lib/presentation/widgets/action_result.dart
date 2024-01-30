import 'package:coding_challenge/presentation/widgets/primary_button.dart';
import 'package:coding_challenge/shared/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A component that supports displaying a column of Widgets (title, subtitle and Lottie animation).
/// it can be with primary button if you provide the [primaryBtnText] and [onPrimaryBtnPressed]
class ActionResult extends StatelessWidget {
  /// The [title] is required argument for widget's title.
  /// The [subtitle] is required argument for widget's subtitle.
  /// The [repeatAnimation] is optional to let Lottie repeat the animation, the default value is false.
  /// The [lottieAsset] is required argument for Lottie animation file path.
  /// [primaryBtnText] is optional argument, if you want to show primary button also you need to provide the [onPrimaryBtnPressed].
  final String title;
  final String subtitle;
  final String lottieAsset;
  final String? primaryBtnText;
  final VoidCallback? onPrimaryBtnPressed;
  final bool? repeatAnimation;
  const ActionResult(
      {super.key,
      required this.lottieAsset,
      required this.title,
      required this.subtitle,
      this.primaryBtnText,
      this.onPrimaryBtnPressed,
      this.repeatAnimation = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(
                top: AppConstants.defaultMargin * 2,
                bottom: AppConstants.defaultMargin),
            height: AppConstants.containerElement * 10,
            width: AppConstants.containerElement * 10,
            child: Lottie.asset(lottieAsset, repeat: repeatAnimation),
          ),
          Text(title, style: Theme.of(context).textTheme.displayLarge),
          Container(
            margin: const EdgeInsets.only(
                bottom: AppConstants.defaultMargin * 2,
                top: AppConstants.marginElement * 3),
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          if (primaryBtnText != null && onPrimaryBtnPressed != null)
            Container(
              margin: const EdgeInsets.only(bottom: AppConstants.defaultMargin),
              width: AppConstants.containerElement * 18,
              child: PrimaryButton(
                  text: primaryBtnText!, onPressed: onPrimaryBtnPressed!),
            )
        ],
      ),
    );
  }
}
