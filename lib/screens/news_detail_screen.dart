import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_beeper/widgets/custom_app_bar.dart';
import 'package:news_beeper/widgets/custom_drawer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../model/news_model.dart';
import '../utils/app_colors.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsModel news;

  NewsDetailScreen({required this.news});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late double _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    String formattedDate =
        DateFormat('EEEE, d MMMM yyyy').format(widget.news.publishedAt);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: _deviceHeight,
          width: _deviceWidth,
          child: Stack(
            children: [
              _backgroundImage(),
              _backButton(),
              _dataList(widget.news.title.toString(), formattedDate,
                  widget.news.author.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backgroundImage() {
    return Positioned(
        child: Container(
      height: _deviceHeight * 0.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: widget.news.urlToImage.toString().isNotEmpty &&
                  widget.news.urlToImage != null
              ? NetworkImage(widget.news.urlToImage.toString())
              : const AssetImage('assets/images/no_news.jpg') as ImageProvider,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
    ));
  }

  Widget _backButton() {
    return Positioned(
      top: _deviceHeight * 0.125,
      left: _deviceWidth * 0.01,
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          )),
    );
  }

  Widget _dataList(String title, String date, String author) {
    return Positioned(
      top: _deviceHeight * 0.43,
      child: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Column(
            children: [
              Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: _deviceWidth * 0.8,
                      padding: EdgeInsets.symmetric(
                          horizontal: _deviceWidth * 0.04,
                          vertical: _deviceHeight * 0.015),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      // Semi-transparent white to enhance blur
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          date.isNotEmpty
                              ? Text(
                                  date,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )
                              : Container(),
                          SizedBox(
                            height: _deviceHeight * 0.002,
                          ),
                          author.isNotEmpty
                              ? Text(
                                  _shortenAuthor(author),
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                )
                              : Container(),
                          SizedBox(
                            height: _deviceHeight * 0.03,
                          ),
                          title.isNotEmpty
                              ? Text(
                                  _shortenTitle(title),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0),
                                )
                              : Container(),
                          SizedBox(
                            height: _deviceHeight * 0.01,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: _deviceHeight * 0.035,
              ),
              _otherDataList(widget.news.description.toString(),
                  widget.news.content.toString(), widget.news.url.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otherDataList(String description, String content, String url) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
      width: _deviceWidth,
      child: Column(
        children: [
          widget.news.description!.isNotEmpty && widget.news.content!.isNotEmpty
              ? Column(
                  children: [
                    Text(
                      widget.news.description.toString(),
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: _deviceHeight * 0.03,
                    ),
                    Text(
                      _processContent(widget.news.content.toString()),
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: _deviceHeight * 0.04,
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: _deviceHeight * 0.05),
                      child: const Text(
                        " ----- No description & content available -----",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: _deviceHeight * 0.03,
                    ),
                  ],
                ),
          SizedBox(
            height: _deviceHeight * 0.01,
          ),
          _newsLink(widget.news.url.toString())
        ],
      ),
    );
  }

  Widget _newsLink(String url) {
    return InkWell(
      child: Container(
        height: _deviceHeight * 0.05,
        width: _deviceWidth * 0.4,
        decoration: BoxDecoration(
            color: AppColors.redColor,
            borderRadius: BorderRadius.circular(10.0)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Read More ... ',
              style: TextStyle(
                  color: AppColors.whiteColor, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      onTap: () => launchUrlString(url),
    );
  }

  String _processContent(String content) {
    String cleanedContent = content.replaceAll(RegExp(r"\[\+\d+ chars\]"), '');
    int cleanContentLength = cleanedContent.length;

    cleanedContent = cleanedContent.substring(0, cleanContentLength);

    return cleanedContent;
  }

  String _shortenTitle(String title) {
    return title.length > 120 ? "${title.substring(0, 120)}..." : title;
  }

  String _shortenAuthor(String author) {
    return author.length > 50
        ? "By ${author.substring(0, 120)}..."
        : "By ${author}";
  }
}
