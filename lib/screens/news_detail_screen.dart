import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
import 'package:news_beeper/widgets/custom_icon_button.dart';
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
  bool _isSpeaking = false;
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.speak(_speechText());
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    flutterTts.setStartHandler(() {
      setState(() {
        _isSpeaking = true;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        _isSpeaking = false;
      });
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

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
      body: SizedBox(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          children: [
            _backgroundImage(),
            _backButton(),
            _dataList(widget.news.title.toString(), formattedDate,
                widget.news.author.toString()),
            Positioned(
                bottom: _deviceHeight * 0.05, right: _deviceWidth * 0.06, child: _iconButtonSet(widget.news.url.toString()))
          ],
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

  Widget _iconButtonSet(String url) {
    return Container(
      width: _deviceWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomIconButton(
              onPressed: _isSpeaking ? stop : speak,
              icon: Icon(_isSpeaking ? Icons.stop  :Icons.record_voice_over ),
              iconSize: 25.0,
              iconColor: Theme.of(context).dividerColor),
          const SizedBox(
            height: 10,
          ),
          CustomIconButton(
              onPressed: () => launchUrlString(url),
              icon: const Icon(Icons.read_more),
              iconSize: 25.0,
              iconColor: Theme.of(context).dividerColor)
        ],
      ),
    );
  }

  Widget _dataList(String title, String date, String author) {
    return Positioned(
      top: _deviceHeight * 0.45,
      height: _deviceHeight * 0.55,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        date.isNotEmpty
                            ? Text(
                                date,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              )
                            : Container(),
                        SizedBox(
                          height: _deviceHeight * 0.002,
                        ),
                        author.isNotEmpty
                            ? Text(
                                author,
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
                                title,
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
            Expanded(
              child: _otherDataList(widget.news.description.toString(),
                  widget.news.content.toString(), widget.news.url.toString()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otherDataList(String description, String content, String url) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
      width: _deviceWidth,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            widget.news.description!.isNotEmpty ||
                    widget.news.content!.isNotEmpty
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
                        height: _deviceHeight * 0.02,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: _deviceHeight * 0.05),
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
              height: _deviceHeight * 0.03,
            ),
          ],
        ),
      ),
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

  String _speechText() {
    if (widget.news.author!.isEmpty) {
      return "${widget.news.title}";
    } else {
      return "${widget.news.title} by ${widget.news.author}";
    }
  }
}
