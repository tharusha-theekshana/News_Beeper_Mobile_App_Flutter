import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_beeper/screens/splash_screen.dart';

// Controllers
import 'controllers/internet_connection_controller.dart';

void main() {
  Get.put(InternetConnectionController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News Beeper',
      darkTheme: ThemeData(
          useMaterial3: true,
          fontFamily: "Quicksand",
          splashFactory: NoSplash.splashFactory,
          colorScheme: const ColorScheme.dark()),
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Quicksand",
          splashFactory: NoSplash.splashFactory,
          colorScheme: const ColorScheme.light()),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


