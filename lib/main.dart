import 'package:flutter/material.dart';
import 'package:news_beeper/screens/home_screen.dart';
import 'package:news_beeper/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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


