import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../model/all_news_model.dart';


class BookmarkManager {
  static const String bookmarksKey = 'bookmarkedArticles';
  Future<void> addBookmark(NewsArticle article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(bookmarksKey) ?? [];

    bookmarks.add(jsonEncode(article.toJson()));
    await prefs.setStringList(bookmarksKey, bookmarks);
  }

  Future<void> removeBookmark(NewsArticle article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(bookmarksKey) ?? [];

    bookmarks.removeWhere((bookmark) {
      var decoded = jsonDecode(bookmark);
      return decoded['title'] == article.title; // Compare by title
    });

    await prefs.setStringList(bookmarksKey, bookmarks);
  }

  Future<List<NewsArticle>> getBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(bookmarksKey) ?? [];
    return bookmarks.map((bookmark) => NewsArticle.fromJson(jsonDecode(bookmark))).toList();
  }

  Future<bool> isBookmarked(NewsArticle article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(bookmarksKey) ?? [];

    return bookmarks.any((bookmark) {
      var decoded = jsonDecode(bookmark);
      return decoded['title'] == article.title;
    });
  }
}

