import 'package:coding_challenge/shared/app_colors.dart';
import 'package:coding_challenge/shared/app_constants.dart';
import 'package:flutter/material.dart';

/// A customized Checkbox widget with Text widget.
class CustomCheckbox extends StatelessWidget {
  /// The [text] is required argument for text widget.
  /// [value] is required argument for the Checkbox widget.
  /// [onChanged] is required argument, function that gets invoked on change tap.
  /// [checkBoxBorderColor] is required argument, for the checkbox border color.
  final Function(bool?)? onChanged;
  final bool value;
  final Color checkBoxBorderColor;
  final String text;
  const CustomCheckbox(
      {super.key,
      required this.text,
      required this.checkBoxBorderColor,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          checkColor: AppColors.white,
          activeColor: AppColors.primary,
          side: BorderSide(
            color: checkBoxBorderColor,
            width: AppConstants.borderElement,
          ),
          onChanged: onChanged,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: AppConstants.paddingElement),
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ))
      ],
    );
  }
}
