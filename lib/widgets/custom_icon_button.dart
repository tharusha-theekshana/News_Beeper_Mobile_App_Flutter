import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_beeper/utils/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Icon icon;
  final double iconSize;
  final Color iconColor;

  CustomIconButton(
      {required this.onPressed,
      required this.icon,
      required this.iconSize,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: AppColors.redColor,
        borderRadius: BorderRadius.circular(50.0)
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        iconSize: iconSize,
        color: iconColor,
      ),
    );
  }
}
