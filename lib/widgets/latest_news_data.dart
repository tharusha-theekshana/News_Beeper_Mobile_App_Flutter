import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_beeper/widgets/news_list.dart';

import '../controllers/news_controller.dart';
import '../model/news_model.dart';
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
            int newsListLength = controller.latestNews.length;
            List<NewsModel> firstTenNews = controller.latestNews.sublist(
              0,
              newsListLength < 10 ? newsListLength : 10,
            );
            return Column(
              children: [
                topLine(context),
                Expanded(
                    child: NewsList(
                  newsList: firstTenNews,
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
                    return Container();
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
