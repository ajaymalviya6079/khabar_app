import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khabar/Utils/colors.dart';
import '../../model/all_news_model.dart';
import '../../routes/app_pages.dart';
import 'bookmark_manager.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({Key? key}) : super(key: key);

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  final BookmarkManager bookmarkManager = BookmarkManager();
  final SwiperController swiperController = SwiperController();
  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('MMM dd, yyyy hh:mm a');
    return formatter.format(dateTime);
  }
  @override
  Widget build(BuildContext context) {
    final itemHeight = MediaQuery.of(context).size.height;
    final itemWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.offWhit,
        title: const Text('Bookmarks',style: TextStyle(fontWeight: FontWeight.w700),),
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: bookmarkManager.getBookmarks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<NewsArticle> bookmarkedArticles = snapshot.data!;
          if (bookmarkedArticles.isEmpty) {
            return const Center(child: Text('No bookmarks yet'));
          }
          return Swiper(
            controller: swiperController,
            itemCount: bookmarkedArticles.length,
            scrollDirection: Axis.vertical,
            layout: SwiperLayout.STACK,
            loop:false,
            onIndexChanged: (index) {

            },
            itemWidth: itemWidth / 1.1,
            itemHeight: itemHeight / 1.4,
            itemBuilder: (BuildContext context, int index) {
              var article = bookmarkedArticles[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.DETAILS, arguments: {
                      'isKey': 'news',
                      'newsData': article
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 10,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        article.urlToImage != null
                            ? Expanded(
                          child: ClipRRect(
                            borderRadius:
                            const BorderRadius.vertical(
                                top: Radius.circular(10)),
                            child: Image.network(
                              article.urlToImage!,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception,
                                  StackTrace? stackTrace) {
                                return Container(
                                  height: 150,
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: AutoSizeText(
                                      "Image not available",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                            : Expanded(
                          child: ClipRRect(
                            borderRadius:
                            const BorderRadius.vertical(
                                top: Radius.circular(10)),
                            child: Image.asset(
                              'assets/images/imageNotFound.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            article.title,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: AutoSizeText(
                            "By ${article.author ?? "Unknown"} - ${formatDateTime(article.publishedAt)}",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            article.description ??
                                "No description available",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),

                        ListTile(
                          trailing: FutureBuilder<bool>(
                            future: bookmarkManager.isBookmarked(article), // Use instance method
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const SizedBox.shrink();
                              }
                              bool isBookmarked = snapshot.data!;
                              return IconButton(
                                icon: Icon(
                                  isBookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: isBookmarked
                                      ? Colors.red
                                      : Colors.black,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    bookmarkManager.removeBookmark(article);
                                  });
                                },
                              );
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              );
            },
            viewportFraction: 1,
            scale: 1,
          );
        },
      ),
    );
  }
}

