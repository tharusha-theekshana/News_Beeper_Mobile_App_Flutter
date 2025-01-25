import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionController extends GetxController {
  var isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    _startMonitoring();
  }

  // Start checking internet connection
  void _startMonitoring() {
    _checkConnection();

    Timer.periodic(const Duration(seconds: 5), (timer) {
      _checkConnection();
    });
  }

  // Check the internet connection
  Future<void> _checkConnection() async {
    bool connectionStatus = await InternetConnectionChecker.instance.hasConnection;
    if (isConnected.value != connectionStatus) {
      isConnected.value = connectionStatus;
    }
  }
}
