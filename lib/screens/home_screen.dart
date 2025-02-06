import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_beeper/controllers/bottom_navigation_controller.dart';
import 'package:news_beeper/controllers/news_controller.dart';
import 'package:news_beeper/screens/news_data_screen.dart';
import 'package:news_beeper/screens/search_screen.dart';
import 'package:news_beeper/widgets/about_app_drawer.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

import '../controllers/internet_connection_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late double _deviceHeight, _deviceWidth;
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  final pageController = PageController();

  final internetConnectionController = Get.find<InternetConnectionController>();
  final bottomNavigationController = Get.put(BottomNavigationController());
  final newsController = Get.put(NewsController());

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _configAnimationController();
  }

  void _configAnimationController() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Glow animation
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Repeat the animation
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return await _showExitConfirmation();
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        drawer: AboutAppDrawer(),
        body: Obx(() {
          return Stack(
            children: [
              PageView(
                controller: pageController,
                onPageChanged: (index) {
                  bottomNavigationController.changeBottomNavigation(currentIndex: index);
                },
                children: [
                  const NewsDataScreen(),
                  SearchScreen()
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: BottomNavigation(
                  deviceHeight: _deviceHeight,
                  deviceWidth: _deviceWidth,
                  pageController: pageController,
                ),
              ),
              if (internetConnectionController.isConnected.value == false)
                _showNoInternetAlert(),
            ],
          );
        }),
      ),
    );
  }

  Widget _showNoInternetAlert() {
    return Center(
      child: Container(
        padding: EdgeInsets.zero,
        width: _deviceWidth,
        height: _deviceHeight,
        color: Colors.black.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return RiveAnimatedIcon(
                    riveIcon: RiveIcon.wifi,
                    width: 75,
                    height: 75,
                    color: AppColors.redColor,
                    strokeWidth: 3,
                    loopAnimation: true,
                    onTap: () {

                    },
                    onHover: (value){}
                );
              },
            ),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            Text(
              "Waiting for connection ... !",
              style: TextStyle(
                fontSize: 16.0,
                  fontFamily: "Quicksand",
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w700,
                  color: AppColors.redColor),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _showExitConfirmation() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        actionsPadding: const EdgeInsets.all(10.0),
        title: const Text(
          'Confirm Exit',
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you want to exit from the app ?',
          style: TextStyle(fontSize: 14.0),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'No',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Theme.of(context).dividerColor
              ),
            ),
          ),
          Container(
            width: 58,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.redColor,
              borderRadius: BorderRadius.circular(25.0)
            ),
            child: TextButton(
              onPressed: () {
                exit(0);
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Theme.of(context).dividerColor
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
