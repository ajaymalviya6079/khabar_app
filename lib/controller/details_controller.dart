import 'package:get/get.dart';
import 'package:khabar/controller/app_base_controller/app_base_conroller.dart';

import '../model/all_news_model.dart';
import '../model/top_headlines_model.dart';

class DetailsController extends AppBaseController {
  NewsArticle? article;
  HeadlineArticle? headlineArticle;

  dynamic get availableArticle => article ?? headlineArticle;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments['isKey'] != null) {
      if (Get.arguments['isKey'] == 'news') {
        article = Get.arguments['newsData'] as NewsArticle?;
        print('News Data-----${article}');
      } else if (Get.arguments['isKey'] == 'heading') {
        headlineArticle = Get.arguments['headingData'] as HeadlineArticle?;
        print('headlines data-----${headlineArticle}');
      }
    }
  }
}

