import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/all_news_model.dart';
import '../model/top_headlines_model.dart';

class HomeController extends GetxController {
  AllNewsResponseModel? allNewsResponse;
  TopHeadlinesResponseModel? topHeadlinesResponse;
  var isLoading = true.obs;
  var isTopHeadlinesLoading = true.obs;
  var selectedCategory = 'Everything'.obs;
  var isPaginating = false;
  int page =1;
  int totalResults = 0;
  var isNewsPaginating = false.obs;
  int newsPage = 1;


  @override
  void onInit() {
    super.onInit();
    fetchNews('Everything');
    fetchTopHeadlines();
  }
///----Time format-------------
  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('MMM dd, yyyy hh:mm a');
    return formatter.format(dateTime);
  }

  final List<String> categories = [
    'Everything',
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];



/// Get All News Data here-----------------------------------------------------------

  void fetchNews(String category, {bool loadMore = false}) async {
    try {
      if (loadMore) {
        isNewsPaginating(true);
      } else {
        isLoading(true);
        newsPage = 1;
      }
      selectedCategory.value = category;

      var queryParam = category == 'Everything' ? 'bitcoin' : category.toLowerCase();
      var response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=$queryParam&page=$newsPage&pageSize=20&apiKey=b343f5b56a084d82b99b07bc1d147c60'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var fetchedNews = AllNewsResponseModel.fromJson(data);
        totalResults = data['totalResults'];

        if (loadMore) {
          allNewsResponse?.articles.addAll(fetchedNews.articles);
          update();
        } else {
          allNewsResponse = fetchedNews;
          update();
        }

        newsPage++;
        update();
      } else {
        Get.snackbar("Error", "Failed to fetch news");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
      isNewsPaginating(false);
    }
  }

  /// Method to load more news--------------
  void loadMoreNews() {
    if (!isPaginating && allNewsResponse != null && allNewsResponse!.articles.length < totalResults) {
      isNewsPaginating(true);
      fetchNews(selectedCategory.value, loadMore: true);
      update();
    }
  }





  ///----Fetch top headlines---------------------------

  void fetchTopHeadlines({bool loadMore = false}) async {
    try {
      if (loadMore) {
        isPaginating = true;
        update();
      } else {
        isTopHeadlinesLoading(true);
        page =1;
        update();
      }


      var response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&page=$page&pageSize=20&apiKey=b343f5b56a084d82b99b07bc1d147c60'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var fetchedHeadlines = TopHeadlinesResponseModel.fromJson(data);
        totalResults = data['totalResults'];  // Set total results from API response

        if (loadMore) {
          topHeadlinesResponse?.articles.addAll(fetchedHeadlines.articles);
          update();
        } else {
          topHeadlinesResponse = fetchedHeadlines;
          update();
        }

        update();
      } else {
        Get.snackbar("Error", "Failed to fetch top headlines");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isTopHeadlinesLoading(false);
      isPaginating = false;
    }
  }


  void loadMoreHeadlines() {
    if (!isPaginating && topHeadlinesResponse != null &&
        topHeadlinesResponse!.articles.length < totalResults) {
         page++;
      fetchTopHeadlines(loadMore: true);
      update();
    }
  }






}


