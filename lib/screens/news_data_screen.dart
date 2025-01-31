import 'package:flutter/material.dart';
import 'package:news_beeper/widgets/latest_news_data.dart';

class NewsDataScreen extends StatefulWidget {
  const NewsDataScreen({super.key});

  @override
  State<NewsDataScreen> createState() => _NewsDataScreenState();
}

class _NewsDataScreenState extends State<NewsDataScreen> {
  late double _deviceHeight, _deviceWidth;

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
        height: _deviceHeight,
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          color: Theme.of(context).dividerColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.03),
              child: Stack(
                children: [
                  Column(
                    children: [
                      LatestNewsData(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }

  Future<void> _onRefresh() async {
    print("Data refreshed!");
  }
}
