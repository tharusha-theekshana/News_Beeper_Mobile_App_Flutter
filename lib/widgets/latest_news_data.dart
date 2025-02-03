import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_beeper/screens/latest_news_screen.dart';
import 'package:news_beeper/widgets/news_list.dart';

import '../controllers/news_controller.dart';
import '../utils/app_colors.dart';

class LatestNewsData extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(right: _deviceHeight * 0.01),
      height: _deviceHeight * 0.23,
      child: GetBuilder<NewsController>(
          init: NewsController(),
          builder: (controller) {
            return Column(
              children: [
                topLine(context),
                Expanded(
                    child: NewsList(
                  newsList: controller.latestNews,
                  axis: Axis.horizontal,
                  height: _deviceHeight,
                  width: _deviceWidth * 0.7,
                ))
              ],
            );
          }),
    );
  }

  Widget topLine(context) {
    return SizedBox(
      width: _deviceWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Latest News",
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return LatestNewsScreen();
                  },
                ));
              },
              child: const Text(
                "Sea all -->",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: AppColors.redColor),
              ))
        ],
      ),
    );
  }
}
