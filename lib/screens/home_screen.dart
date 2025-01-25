import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/internet_connection_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final internetConnectionController = Get.find<InternetConnectionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: Obx(() {
           if (internetConnectionController.isConnected.value) {
             return Text("You are connected to the internet!");
           } else {
             return Container();
           }
         },),
      ),
    );
  }
}
