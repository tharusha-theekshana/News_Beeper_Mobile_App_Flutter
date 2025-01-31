import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AboutAppDrawer extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Drawer(
      elevation: 1.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.03),
        height: _deviceHeight,
        width: _deviceWidth,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset('assets/images/splash_icon.png',
                  width: _deviceWidth * 0.6, height: _deviceHeight * 0.4),
            ),
            const Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Text(
                      "Welcome to NewsBeeper ,\n"
                      "your go-to app for staying updated "
                      "with the latest news from around the world! "
                      "Designed with user experience in mind, "
                      "NewsBeeper offers a seamless and engaging way "
                      "to access real-time news articles, features, "
                      "and stories from various categories, including politics, "
                      "technology, entertainment, and sports.",
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      " Stay informed with timely updates on breaking "
                      "news and trending stories from reputable sources, "
                      "ensuring you never miss important information. "
                      "Customize your reading experience with our dark and "
                      "light mode options, perfect for any time of day or "
                      "lighting condition."
                      "Additionally, tailor your news feed based on your interests and preferences, "
                      "allowing you to discover content that resonates with you. ",
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Download and still updated with NewsBeeper today and start exploring "
                      "the news like never before !",
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
            const Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Version - 1.0.0",
                      style: TextStyle(
                          fontSize: 11.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Created By ",
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Tharusha Theekshana",
                            style: TextStyle(
                                color: AppColors.redColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0))
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
