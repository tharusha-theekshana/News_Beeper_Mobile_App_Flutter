import 'package:flutter/material.dart';
import 'package:news_beeper/model/news_model.dart';
import 'package:news_beeper/screens/news_detail_screen.dart';

import '../utils/app_colors.dart';

class NewsList extends StatelessWidget {
  List<NewsModel> newsList;
  Axis axis;
  double width;
  double height;

  NewsList(
      {required this.newsList,
      required this.axis,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
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
                      return NewsDetailScreen(news: news);
                    },
                  ));
                },
                child: Stack(
                  children: [
                    Container(
                      width: width,
                      height: height,
                      margin: axis == Axis.horizontal
                          ? EdgeInsets.only(
                              top: height * 0.02, right: width * 0.04)
                          : EdgeInsets.symmetric(vertical: height * 0.03),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: news.urlToImage != null &&
                                  news.urlToImage!.isNotEmpty
                              ? _isValidImageExtension(news.urlToImage!)
                                  ? NetworkImage(
                                      Uri.encodeFull(news.urlToImage!))
                                  : const AssetImage(
                                          'assets/images/no_news.jpg')
                                      as ImageProvider
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
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: axis == Axis.horizontal
                              ? height * 0.02
                              : height * 0.05,
                          horizontal: width * 0.04),
                      width: width,
                      height: height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          news.author!.isNotEmpty
                              ? Text(
                                  "By ${news.author}",
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      color: AppColors.whiteColor),
                                )
                              : Container(),
                          SizedBox(
                            height: axis == Axis.horizontal
                                ? height * 0.025
                                : height * 0.15,
                          ),
                          Text(
                            textAlign: TextAlign.start,
                            news.title.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
            : Container();
      },
    );
  }

  // Check image extensions
  bool _isValidImageExtension(String url) {
    final validExtensions = ['.png', '.jpg', '.jpeg'];
    final fileExtension = url.replaceAll(RegExp(r'\?.*$'), '').toLowerCase();
    return validExtensions.any((ext) => fileExtension.endsWith(ext));
  }

  String _shortenAuthor(String author) {
    if (author.length > 63) {
      return author.substring(0, 63) + '...'; // Truncate if longer than 63
    }
    return author;
  }
}
