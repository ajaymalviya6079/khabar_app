import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khabar/controller/details_controller.dart';
import '../../Utils/colors.dart';
import '../../controller/home_controller.dart';
import '../webview_page/webview.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsController>(
      init: DetailsController(),
      builder: (controller) {
        var articleData = controller.availableArticle;
        return Scaffold(
          appBar: AppBar(
            title: const AutoSizeText(
              'News Details',
              style: TextStyle(
                  fontWeight: FontWeight.w700, color: AppColors.black),
            ),
            backgroundColor: AppColors.offWhit,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                articleData?.urlToImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          articleData!.urlToImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Container(
                              height: 150,
                              color: Colors.grey[300],
                              child: const Center(
                                child: AutoSizeText(
                                  "Image not available",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        height: 150,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Text(
                            "Image not available",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ),
                const SizedBox(height: 16),
                AutoSizeText(
                  articleData?.title ?? "No title available",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                AutoSizeText(
                  "By ${articleData?.author ?? "Unknown"} - ${Get.find<HomeController>().formatDateTime(articleData?.publishedAt ?? '')}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                AutoSizeText(
                  articleData?.description ?? "No description available",
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: articleData?.url != null
                      ? () => Get.to(WebViewPage(url: articleData!.url!))
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    backgroundColor: AppColors.red,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text(
                    'Read Full Article',
                    style: TextStyle(color: AppColors.whit),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

