import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:http/http.dart' as http;

import '../model/news_model.dart';

class ApiService extends GetConnect implements GetxService{


  // Get headlines API call
  Future<List<NewsModel>> getHeadLines() async {
    try {
      final response = await http.get(Uri.parse("${dotenv.env['BASE_URL']}/top-headlines?country=us&apiKey=${dotenv.env['API_KEY']}"));

      if (response.statusCode == 200) {
        List data = json.decode(response.body)['articles'];
        List<NewsModel> news = data.map((e) => NewsModel.fromJson(e)).toList();
        print(news.length);
        return news;
      } else {
        throw Exception('Failed to load headlines');
      }
    } catch (e) {
      print("Error fetching headlines: $e");
      return [];
    }
  }

  // Get news category wise API call
  Future<List<NewsModel>> getCategoryNews({required String category}) async {
    try {
      final response = await http.get(Uri.parse("${dotenv.env['BASE_URL']}/top-headlines?country=us&category=$category&apiKey=${dotenv.env['API_KEY']}"));

      if (response.statusCode == 200) {
        List data = json.decode(response.body)['articles'];
        List<NewsModel> news = data.map((e) => NewsModel.fromJson(e)).toList();
        return news;
      } else {
        throw Exception('Failed to load headlines');
      }
    } catch (e) {
      print("Error fetching headlines: $e");
      return [];
    }
  }

}

