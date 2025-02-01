import 'package:flutter/material.dart';
import 'package:news_beeper/utils/app_colors.dart';

class TabBarSet extends StatelessWidget {
  final TabController tabController;
  final List<String> list;
  final double deviceWidth;

  const TabBarSet({
    Key? key,
    required this.tabController,
    required this.list,
    required this.deviceWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth,
      height: 35.0,
      child: TabBar(
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: AppColors.redColor,
          borderRadius: BorderRadius.circular(32),
        ),
        unselectedLabelColor: AppColors.grayColor,
        labelColor: AppColors.whiteColor,
        dividerColor: Colors.transparent,
        tabs: list.map((category) {
          return Tab(
            child: Text(
              category,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
            ),
          );
        }).toList(),
      ),
    );
  }
}
