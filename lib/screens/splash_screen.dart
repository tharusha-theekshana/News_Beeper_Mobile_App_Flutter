import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
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
      ),
    );
  }
}
