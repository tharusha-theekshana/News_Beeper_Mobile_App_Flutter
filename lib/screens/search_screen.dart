import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_beeper/utils/app_colors.dart';
import 'package:news_beeper/widgets/custom_search_bar.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

import '../controllers/news_controller.dart';
import '../model/news_model.dart';
import '../widgets/news_list.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late double _deviceHeight, _deviceWidth;
  final getStorage = GetStorage();

  final TextEditingController searchController = TextEditingController();

  final newsController = Get.put(NewsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsController.searchNews = [];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    newsController.searchNews = [];
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<NewsController>(
        init: NewsController(),
        builder: (controller) {
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: _deviceWidth * 0.02,
                vertical: _deviceHeight * 0.01),
            height: _deviceHeight,
            width: _deviceWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 9,
                        child: CustomSearchBar(
                          controller: searchController,
                          onSubmit: (value) =>
                              controller.getSearchNews(searchText: value),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                searchController.text.isNotEmpty
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: _deviceWidth * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              " Search Text : ${searchController.value.text}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontSize: 13.0),
                            ),
                            Text(
                              "Results : ${newsController.searchNews.length} ",
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontSize: 13.0),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Expanded(
                      child: Center(
                        child: RiveAnimatedIcon(
                            riveIcon: RiveIcon.search,
                            width: 50,
                            height: 50,
                            color: AppColors.redColor,
                            strokeWidth: 3,
                            loopAnimation: true,
                            onTap: () {},
                            onHover: (value){}
                        ),
                      ),
                    );
                  } else if (controller.searchNews.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.newspaper_outlined,size: 35,),
                            SizedBox(
                              height: 10,
                            ),
                            Text("No News Available",style: TextStyle(
                              fontWeight: FontWeight.w500
                            ),)
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: _deviceHeight * 0.01,
                            horizontal: _deviceWidth * 0.02),
                        child: NewsList(
                          newsList: newsController.searchNews,
                          axis: Axis.vertical,
                          width: _deviceWidth,
                          height: _deviceHeight * 0.23,
                        ),
                      ),
                    );
                  }
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
