import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khabar/controller/app_base_controller/app_base_conroller.dart';
import '../model/recommendation_response_model.dart';
import 'package:http/http.dart'as http;

import '../services/api_client.dart';



class TopArticleController extends AppBaseController {
  RecommendationResponseModel? recommendationResponse;
  final ScrollController scrollController = ScrollController();
  var isRePaginating = false.obs;
  int recommendationPage = 1;
  int totalResults = 0;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecommendationNews();  // Fetch initial data
    scrollController.addListener(scrollListener);  // Attach scroll listener
  }


  ///Time format----------------------------------------------------------------
  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return "No Date Available";
    }
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }


  /// Fetch Recommendation News-------------------------------------------------
  void fetchRecommendationNews({bool loadMore = false}) async {
    try {
      if (loadMore) {
        isRePaginating(true);
        update();
      } else {
        isLoading(true);
        recommendationPage = 1;
        update();
      }

      var response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=apple&page=$recommendationPage&pageSize=20&apiKey=${ApiClient.apiKey}'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var fetchedNews = RecommendationResponseModel.fromJson(data);
        totalResults = data['totalResults'] ?? 0;  // Ensure `totalResults` is not null

        if (loadMore) {
          recommendationResponse?.articles?.addAll(fetchedNews.articles ?? []);
          update();
        } else {
          recommendationResponse = fetchedNews;
          update();
        }

        recommendationPage++;
        update();
      } else {
        Get.snackbar("Error", "Failed to fetch news with status code ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch news: ${e.toString()}");
    } finally {
      isLoading(false);
      isRePaginating(false);
    }
  }

  /// Method to load more news (pagination)
  void loadMoreRecommendation() {
    if (!isRePaginating.value &&
        recommendationResponse != null && (recommendationResponse!.articles?.length ?? 0) < totalResults) {
      fetchRecommendationNews(loadMore: true);
      update();
    }
  }

  /// Scroll listener to trigger loading more data when reaching near the end
  void scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200 &&
        !isRePaginating.value) {
      loadMoreRecommendation();  // Load more when scrolled near the bottom
    }
  }

  @override
  void dispose() {
    scrollController.dispose();  // Dispose of the scroll controller
    super.dispose();
  }
}
