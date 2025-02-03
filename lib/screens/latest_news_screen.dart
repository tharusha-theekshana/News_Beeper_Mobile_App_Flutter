import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controllers/news_controller.dart';
import '../widgets/news_list.dart';

class LatestNewsScreen extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Latest News",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: body(),
    );
  }

  Widget body() {
    return GetBuilder<NewsController>(
        init: NewsController(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.025),
            child: NewsList(
              newsList: controller.latestNews,
              axis: Axis.vertical,
              width: _deviceWidth,
              height: _deviceHeight * 0.23,
            ),
          );
        });
  }
}
