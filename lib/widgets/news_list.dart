import 'package:flutter/material.dart';
import 'package:news_beeper/model/news_model.dart';

import '../utils/app_colors.dart';

class NewsList extends StatelessWidget {
  List<NewsModel> newsList;
  Axis axis;
  double width;
  double height;
  late double _deviceHeight, _deviceWidth;

  NewsList(
      {required this.newsList,
      required this.axis,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: newsList.length,
      scrollDirection: axis,
      itemBuilder: (context, index) {
        var news = newsList[index];

        return news.title != "[Removed]"
            ? GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Container();
                    },
                  ));
                },
                child: Container(
                  width: width,
                  height: height,
                  margin: axis == Axis.horizontal ? EdgeInsets.only(top: _deviceHeight * 0.02,right: _deviceWidth * 0.04) : EdgeInsets.zero,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: news.urlToImage != null &&
                              news.urlToImage!.isNotEmpty
                          ? _isValidImageExtension(news.urlToImage!)
                              ? NetworkImage(Uri.encodeFull(news.urlToImage!))
                              :  const AssetImage('assets/images/no_news.jpg') as ImageProvider
                          : const AssetImage('assets/images/no_news.jpg')
                              as ImageProvider,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      colorFilter: ColorFilter.mode(
                        Colors.black
                            .withOpacity(0.4), // Darkens the image slightly
                        BlendMode
                            .darken, // Adjusts how the color filter is applied
                      ),
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 100,
                        left: 20,
                        width: _deviceWidth * 0.70,
                        child: news.author!.isNotEmpty
                            ? Text(
                                "By ${news.author}", style: const TextStyle(
                          fontSize: 12.0,
                          color: AppColors.whiteColor
                        ),
                              )
                            : Container(),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        width: _deviceWidth * 0.74,
                        child: Text(
                          textAlign: TextAlign.start,
                          news.title.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container();
      },
    );
  }


  // Check image extensions
  bool _isValidImageExtension(String url) {
    final validExtensions = ['.png', '.jpg', '.jpeg'];
    final fileExtension = url.split('?')[0].toLowerCase();
    return validExtensions.any((ext) => fileExtension.endsWith(ext));
  }
}
