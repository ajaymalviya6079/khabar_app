import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:khabar/Utils/colors.dart';
import 'package:khabar/controller/home_controller.dart';
import '../../routes/app_pages.dart';
import '../bookmark/bookmark_manager.dart';


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.offWhit,
            leading: const Icon(
              Icons.dehaze_outlined,
              color: AppColors.black,
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.notifications, color: AppColors.black),
              ),
            ],
            title: TabBar(
              controller: _tabController,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.black54,
              indicatorColor: Colors.red,
              tabs: const [
                Tab(text: 'Summary'),
                Tab(text: 'Headlines'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              SummarySwiper(),
              HeadlinesList(),
            ],
          ),
        );
      },
    );
  }
}

class SummarySwiper extends StatelessWidget {
  SummarySwiper({super.key});

  final SwiperController swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    final itemHeight = MediaQuery.of(context).size.height;
    final itemWidth = MediaQuery.of(context).size.width;
    final BookmarkManager bookmarkManager = BookmarkManager();
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Obx(() => ChoiceChip(
                            label: Text(category),
                            selected:
                                controller.selectedCategory.value == category,
                            onSelected: (bool selected) {
                              if (selected) {
                                controller.fetchNews(category);
                                controller.update();
                              }
                            },
                            backgroundColor: Colors.grey[200],
                            selectedColor: Colors.red[300],
                            labelStyle: TextStyle(
                              color:
                                  controller.selectedCategory.value == category
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          )),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (controller.isLoading.value)
              const Expanded(
                child: Center(
                    child: SpinKitFadingCircle(color: AppColors.red, size: 50)),
              )
            else if (controller.allNewsResponse!.articles.isEmpty)
              const Expanded(child: Center(child: Text('No news found')))
            else
              Expanded(
                child: Swiper(
                  controller: swiperController,
                  itemCount: controller.allNewsResponse!.articles.length,
                  scrollDirection: Axis.vertical,
                  layout: SwiperLayout.STACK,
                  loop: true,
                  onIndexChanged: (index) {
                    if (index ==
                            controller.allNewsResponse!.articles.length - 1 &&
                        !controller.isPaginating) {
                      controller.loadMoreNews();
                    }
                  },
                  itemWidth: itemWidth / 1.1,
                  itemHeight: itemHeight / 1.4,
                  itemBuilder: (BuildContext context, int index) {
                    var article = controller.allNewsResponse?.articles[index];
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
                              article!.urlToImage != null
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
                                  "By ${article.author ?? "Unknown"} - ${controller.formatDateTime(article.publishedAt)}",
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
                                        if (isBookmarked) {
                                          await bookmarkManager.removeBookmark(article); // Use instance method
                                        } else {
                                          await bookmarkManager.addBookmark(article); // Use instance method
                                        }
                                        controller.update();
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
                ),
              ),
            if (controller.isNewsPaginating.value)
              const Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                    child: SpinKitFadingCircle(
                  color: AppColors.red,
                  size: 50,
                )),
              ),
          ],
        );
      },
    );
  }
}

class HeadlinesList extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  HeadlinesList({super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          !Get.find<HomeController>().isPaginating) {
        Get.find<HomeController>().loadMoreHeadlines();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        if (controller.isTopHeadlinesLoading.value && controller.page == 5) {
          return const Center(
              child: SpinKitFadingCircle(color: AppColors.red, size: 50));
        } else if (controller.topHeadlinesResponse?.articles.isEmpty ?? true) {
          return const Center(child: Text('No top headlines available'));
        } else {
          return ListView.builder(
            controller: _scrollController,
            itemCount: controller.topHeadlinesResponse!.articles.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.topHeadlinesResponse?.articles.length) {
                return controller.isPaginating
                    ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: SpinKitFadingCircle(
                          color: AppColors.red, size: 50)),
                )
                    : const SizedBox.shrink();
              }

              var topArticle = controller.topHeadlinesResponse?.articles[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 4),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: topArticle?.urlToImage != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        topArticle!.urlToImage!,
                        height: 110,
                        width: 90,
                        fit: BoxFit.fill,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Container(
                            height: 90,
                            width: 90,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image_not_supported, size: 30, color: Colors.grey),
                            ),
                          );
                        },
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/imageNotFound.png',
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: AutoSizeText(
                      topArticle!.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: AutoSizeText(
                        topArticle.description ?? 'No description available',
                        style: const TextStyle(fontSize: 13, color: Colors.black54),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.red),
                    onTap: () {
                      Get.toNamed(Routes.DETAILS, arguments: {
                        'isKey': 'heading',
                        'headingData': topArticle
                      });
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

