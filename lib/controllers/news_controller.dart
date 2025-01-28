import 'package:get/get.dart';
import 'package:news_beeper/model/news_model.dart';

import '../services/api_service.dart';

class NewsController extends GetxController{

  ApiService apiService = ApiService();

  List<NewsModel> latestNews = [];

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


  @override
  void onInit() {
    // TODO: implement onInit
    getLatestNews();
    super.onInit();
  }

}