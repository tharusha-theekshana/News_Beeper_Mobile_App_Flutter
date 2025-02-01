import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_beeper/widgets/tab_bar_set.dart';

import '../controllers/news_controller.dart';
import '../shared/category_list.dart';
import '../utils/app_colors.dart';
import 'news_list.dart';

class CategoryNewsData extends StatefulWidget {
  @override
  State<CategoryNewsData> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryNewsData>
    with SingleTickerProviderStateMixin {
  late double _deviceHeight, _deviceWidth;


  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController =
        TabController(length: CategoryList.categoryItems.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.02),
              child: Column(
                children: [
                  SizedBox(
                    height: _deviceHeight * 0.015,
                  ),
                  TabBarSet(
                      tabController: tabController,
                      list: CategoryList.categoryItems,
                      deviceWidth: _deviceWidth),
                  SizedBox(
                    height: _deviceHeight * 0.02,
                  ),
                  _newsListOfCategories()
                ],
              ),
            )));
  }

  Widget _newsListOfCategories() {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: CategoryList.categoryItems.map((e) {
          return GetBuilder<NewsController>(
            init: NewsController(),
            builder: (controller) => FutureBuilder(
              future: tabController.indexIsChanging || tabController.index == 0
                  ? controller.getCategoryNews(category: e)
                  : null,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return NewsList(
                      newsList: snapshot.data!,
                      axis: Axis.vertical,
                      width: _deviceWidth,
                      height: _deviceHeight * 0.25);
                } else {
                  return const Center(
                    child: SizedBox(
                      height: 25.0,
                      width: 25.0,
                      child: CircularProgressIndicator(
                        color: AppColors.redColor,
                      ),
                    ),
                  );
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
