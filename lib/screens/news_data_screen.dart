import 'package:flutter/material.dart';
import 'package:news_beeper/widgets/category_news_data.dart';
import 'package:news_beeper/widgets/latest_news_data.dart';

class NewsDataScreen extends StatefulWidget {
  const NewsDataScreen({super.key});

  @override
  State<NewsDataScreen> createState() => _NewsDataScreenState();
}

class _NewsDataScreenState extends State<NewsDataScreen> {
  late double _deviceHeight, _deviceWidth;

  final pageController = PageController();
  GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      child: RefreshIndicator(
        key: _refreshKey,
        onRefresh: _onRefresh,
        color: Theme.of(context).dividerColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: _deviceHeight * 0.9,
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.03),
            child: Stack(
              children: [
                Column(
                  children: [
                    LatestNewsData(),
                    SizedBox(
                      height: _deviceHeight * 0.02,
                    ),
                    Expanded(child: CategoryNewsData())
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
    setState(() {
      _refreshKey = GlobalKey<RefreshIndicatorState>();
    });
  }
}
