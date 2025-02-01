import 'package:get/get.dart';
import 'package:news_beeper/model/news_model.dart';

import '../services/api_service.dart';

class NewsController extends GetxController{

  ApiService apiService = ApiService();

  List<NewsModel> latestNews = [];
  List<NewsModel> categoryNewsList = [];

  var isLoading = false.obs;

  // Get latest news
  Future<void> getLatestNews() async {
    try{
      List<NewsModel> fetchedNewsList = await apiService.getHeadLines();
      latestNews = fetchedNewsList.where((news) => news.title != "[Removed]").toList();
      update();
    }catch(e){
      print(e.toString());
    }
  }

  // Get category news
  Future<List<NewsModel>> getCategoryNews({required String category}) async {
    try{
      List<NewsModel> fetchedNewsList  = await apiService.getCategoryNews(category: category);
      categoryNewsList = fetchedNewsList.where((news) => news.title != "[Removed]").toList();
      update();
      return categoryNewsList;
    }catch(e){
      print(e.toString());
      return [];
    }
  }


  @override
  void onInit() {
    // TODO: implement onInit
    getLatestNews();
    super.onInit();
  }

}