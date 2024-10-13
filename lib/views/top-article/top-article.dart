import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../Utils/colors.dart';
import '../../controller/top_article_controller.dart';


class TopArticle extends StatefulWidget {
  const TopArticle({super.key});

  @override
  State<TopArticle> createState() => _TopArticleState();
}

class _TopArticleState extends State<TopArticle> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopArticleController>(
      init: TopArticleController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.offWhit,
            title: const Text(
              'Top Articles',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          body: controller.isLoading.value
              ? const Center(
                  child: SpinKitFadingCircle(
                    color: AppColors.red,
                    size: 50,
                  ),
                )
              : Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                    controller: controller.scrollController,
                    itemCount: (controller.recommendationResponse?.articles?.length ?? 0) + 1, // Add 1 for the loader
                    itemBuilder: (context, index) {
                      if (index == (controller.recommendationResponse?.articles?.length ?? 0)) {
                        return controller.isRePaginating.value
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                  child: SpinKitFadingCircle(
                                    color: AppColors.red,
                                    size: 30,
                                  ),
                                ),
                              )
                            : const SizedBox();
                      }
                      var article = controller.recommendationResponse?.articles?[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color:AppColors.offWhit,
                                offset: Offset(0, 4),
                                blurRadius:5,
                                spreadRadius:4,
                              ),
                            ],
                          ),
                          child:Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                child: Image.network(
                                  article?.urlToImage ?? '',
                                  fit: BoxFit.fill,
                                  width: 110,
                                  height: 140,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 110,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        article?.title ?? 'No Title',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      AutoSizeText(
                                        article?.description ?? 'No Description',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                        ),
                                      ),
                                      AutoSizeText(
                                        article!.author.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines:1,
                                        style: const TextStyle(
                                          color:AppColors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      AutoSizeText(
                                        article.publishedAt != null
                                            ? controller.formatDateTime(article.publishedAt!)
                                            : "No Date Available", // Fallback for null value
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ),
        );
      },
    );
  }
}







