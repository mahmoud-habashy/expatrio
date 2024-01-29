import 'package:coding_challenge/shared/app_assets.dart';
import 'package:coding_challenge/shared/app_constants.dart';
import 'package:coding_challenge/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// This widget for the error states.
class ErrorScreen extends StatelessWidget {
  /// The [title] is required argument for the widget's title.
  /// [subtitle] is required argument for the widget's subtitle.
  /// [onRefresh] is required argument, the VoidCallback function that gets invoked when user clicks on primary button.
  /// [buttonText] is required argument for the primary button's title.
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onRefresh;
  const ErrorScreen(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.buttonText,
      required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.dashboardNeedTaxDataImage,
            height: AppConstants.containerElement * 21,
            width: AppConstants.containerElement * 18,
          ),
          Text(title, style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: AppConstants.containerElement),
          SizedBox(
            width: AppConstants.containerElement * 20,
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: AppConstants.marginElement * 5),
            width: AppConstants.containerElement * 16,
            child: PrimaryButton(text: buttonText, onPressed: onRefresh),
          ),
        ],
      ),
    );
  }
}
