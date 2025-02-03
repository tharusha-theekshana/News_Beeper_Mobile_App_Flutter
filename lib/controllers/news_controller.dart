import 'package:get/get.dart';
import 'package:news_beeper/model/news_model.dart';

import '../services/api_service.dart';

class NewsController extends GetxController{

  ApiService apiService = ApiService();

  List<NewsModel> latestNews = [];
  List<NewsModel> categoryNewsList = [];
  List<NewsModel> searchNews = [];

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


  // Get news for search results
  Future<List<NewsModel>> getSearchNews({required String searchText}) async {
    try{
      isLoading(true);

      List<NewsModel> fetchedNewsList = await apiService.getSearchNews(searchText: searchText);
      searchNews = fetchedNewsList.where((news) => news.title != "[Removed]").toList();
      update();

      isLoading(false);
      return searchNews;

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