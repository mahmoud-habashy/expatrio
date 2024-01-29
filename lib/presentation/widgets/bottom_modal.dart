import 'package:coding_challenge/shared/app_colors.dart';
import 'package:coding_challenge/shared/app_constants.dart';
import 'package:flutter/material.dart';

void showSnackBarMessage(
    {required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message,
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: AppColors.white, fontWeight: FontWeight.w500)),
    duration: const Duration(milliseconds: AppConstants.animationDuration * 2),
    backgroundColor: AppColors.grey,
  ));
}

Future<void> openBottomSheet(
    {required BuildContext context, required Widget content}) {
  return showModalBottomSheet(
    enableDrag: false,
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppConstants.radiusElement * 7),
        topRight: Radius.circular(AppConstants.radiusElement * 7),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 2 / 3),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          width: double.infinity,
          child: SafeArea(child: content));
    },
  );
}
