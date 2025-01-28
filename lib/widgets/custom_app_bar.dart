import 'package:flutter/material.dart';
import 'package:news_beeper/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text("News Beeper",style: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.redColor,
        fontSize: 23.0
      ),),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
