import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_beeper/screens/home_screen.dart';

import '../utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late double _deviceHeight, _deviceWidth;
  late Timer _connectionTimer;

  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _startConnectionCheck();

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

  void _startConnectionCheck() {
    _connectionTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _checkInternetConnection();
    });
  }

  void _checkInternetConnection() async {
    bool isConnected = await InternetConnectionChecker.instance.hasConnection;

    if (isConnected != _isConnected) {
      setState(() {
        _isConnected = isConnected;
      });

      if (_isConnected) {
        _connectionTimer.cancel();
        Get.off(const HomeScreen());
      }
    } else {
      setState(() {
        _isConnected = !isConnected;
      });
    }
  }

  @override
  void dispose() {
    _connectionTimer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
          child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/splash_icon.png',
                  width: _deviceWidth * 0.7, height: _deviceHeight * 0.3),
              const SizedBox(height: 20),
              const SizedBox(
                width: 23.0,
                height: 23.0,
                child: CircularProgressIndicator(
                  color: AppColors.redColor,
                  strokeWidth: 3.0,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: _deviceHeight * 0.02, // Adjust vertical positioning
            left: 0,
            right: 0, // Ensure it's stretched horizontally
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Text(
                    _isConnected
                        ? "Checking Internet Connection ... !"
                        : "Waiting for Internet Connection ... !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .color!
                          .withOpacity(0.5),
                      shadows: [
                        Shadow(
                          blurRadius: 1.1,
                          color: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .color!
                              .withOpacity(_glowAnimation.value),
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
