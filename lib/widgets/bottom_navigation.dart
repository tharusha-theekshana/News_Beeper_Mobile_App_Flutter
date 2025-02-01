import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_beeper/utils/app_colors.dart';

import '../controllers/bottom_navigation_controller.dart';

class BottomNavigation extends StatelessWidget {
  final double deviceHeight;
  final double deviceWidth;
  final PageController pageController;

  BottomNavigation({
    required this.deviceHeight,
    required this.deviceWidth,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BottomNavigationController(),
      builder: (controller) =>  Container(
        margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.28),
        decoration: BoxDecoration(
          color: AppColors.redColor,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).dividerColor.withOpacity(0.3),
              blurRadius: 10.0,
              spreadRadius: 0.5,
              offset: const Offset(0, 0),
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BottomNavigationBar(
            backgroundColor: AppColors.redColor.withOpacity(0.5),
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.index,
            selectedItemColor: AppColors.whiteColor,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
            ),
            unselectedItemColor: AppColors.grayColor,
            unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 10.0,
            ),
            unselectedIconTheme: const IconThemeData(
              size: 20.0
            ),
            onTap: (index) {
              controller.changeBottomNavigation(currentIndex: index);
              pageController.jumpToPage(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
                tooltip: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search),
                label: 'Search',
                tooltip: 'Search',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
