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

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.offWhit,
            leading: const Icon(Icons.dehaze_outlined, color: AppColors.black),
            title: controller.isSearching.value
                ? TextField(
                    controller: _searchController,
                    onSubmitted: (value) {
                      controller.searchNews(value);
                      controller.update();
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search news...',
                      border: InputBorder.none,
                    ),
                    autofocus: true,
                  )
                : TabBar(
                    controller: _tabController,
                    labelColor:AppColors.red,
                    unselectedLabelColor: Colors.black54,
                    indicatorColor:AppColors.red,
                    tabs: const [
                      Tab(text: 'Summary'),
                      Tab(text: 'Headlines'),
                    ],
                  ),
            actions: [
              controller.isSearching.value
                  ? IconButton(
                      icon: const Icon(Icons.close, color: AppColors.black),
                      onPressed: () {
                        _searchController.clear();
                        controller.toggleSearchMode();
                        controller.fetchNews(controller
                            .selectedCategory.value); // Reset to category news
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.search, color: AppColors.black),
                      onPressed: () {
                        controller.toggleSearchMode();
                      },
                    ),
            ],
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
                        selected: controller.selectedCategory.value == category,
                        onSelected: (bool selected) {
                          if (selected) {
                            controller.fetchNews(category);
                            controller.update();
                          }
                        },
                        backgroundColor:AppColors.offWhit,
                        selectedColor: AppColors.red,
                        checkmarkColor:controller.selectedCategory.value == category
                            ? Colors.white
                            : Colors.black,
                        labelStyle: TextStyle(
                          color: controller.selectedCategory.value == category
                              ? Colors.white
                              : Colors.black,
                        ),
                      )),
                    );
                  }).toList(),
                ),
              ),
            ),
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
                  controller: controller.swiperController,
                  itemCount: controller.allNewsResponse!.articles.length??0,
                  scrollDirection: Axis.vertical,
                  layout: SwiperLayout.STACK,
                  loop: true,
                  allowImplicitScrolling: false,
                  onIndexChanged: (index) {
                    if (index == controller.allNewsResponse!.articles.length - 1 &&
                        !controller.isPaginating) {
                      controller.loadMoreNews();
                    }
                  },
                  itemWidth: itemWidth / 1.15,
                  itemHeight: itemHeight / 1.45,
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
                                  borderRadius: const BorderRadius.vertical(
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
                                  borderRadius: const BorderRadius.vertical(
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
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: AutoSizeText(
                                  "By ${article.author ?? "Unknown"} - ${controller.formatDateTime(article.publishedAt)}",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  article.description ?? "No description available",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              ListTile(
                                trailing: FutureBuilder<bool>(
                                  future: bookmarkManager.isBookmarked(article),
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
                                          await bookmarkManager.removeBookmark(article);
                                        } else {
                                          await bookmarkManager.addBookmark(article);
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
                        color: AppColors.red, size: 50),
                  ),
                )
                    : const SizedBox.shrink();
              }

              var topArticle = controller.topHeadlinesResponse?.articles[index];
              return Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.DETAILS, arguments: {
                      'isKey': 'heading',
                      'headingData': topArticle
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          child: topArticle?.urlToImage != null
                              ? Image.network(
                            topArticle?.urlToImage ?? '',
                            width: 110,
                            height: 124,
                            fit: BoxFit.fill,
                            errorBuilder:
                                (context, error, stackTrace) {
                              return Container(
                                width: 110,
                                height: 124,
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
                          )
                              : Image.asset(
                            'assets/images/imageNotFound.png',
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
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
                                  topArticle?.title ?? 'No Title',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                AutoSizeText(
                                  topArticle?.description ??
                                      'No description available',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                AutoSizeText(
                                  topArticle?.content ??
                                      'No available',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColors.red,
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.DETAILS, arguments: {
                              'isKey': 'heading',
                              'headingData': topArticle
                            });
                          },
                        ),
                      ],
                    ),
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





