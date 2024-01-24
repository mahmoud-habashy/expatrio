import 'package:coding_challenge/constants/colors.dart';
import 'package:coding_challenge/constants/doubles.dart';
import 'package:flutter/material.dart';

class ChipButton extends StatelessWidget {
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
            vertical: AppDoubles.paddingElement * 4,
            horizontal: AppDoubles.paddingElement * 7),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppDoubles.defaultRadius),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDoubles.defaultRadius),
                  border: Border.all(
                      width: AppDoubles.borderElement, color: contentColor)),
              child: Icon(
                icon,
                size: AppDoubles.iconSize * 4,
                color: contentColor,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: AppDoubles.paddingElement * 2),
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
