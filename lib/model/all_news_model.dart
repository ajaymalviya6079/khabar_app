
import 'dart:convert';

AllNewsResponseModel allNewsResponseModelFromJson(String str) => AllNewsResponseModel.fromJson(json.decode(str));

String allNewsResponseModelToJson(AllNewsResponseModel data) => json.encode(data.toJson());

class AllNewsResponseModel {
  String status;
  int totalResults;
  List<NewsArticle> articles;

  AllNewsResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory AllNewsResponseModel.fromJson(Map<String, dynamic> json) => AllNewsResponseModel(
    status: json["status"] ?? '',
    totalResults: json["totalResults"] ?? 0,
    articles: json["articles"] != null
        ? List<NewsArticle>.from(json["articles"].map((x) => NewsArticle.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class NewsArticle {
  Source source;
  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  String? content;

  NewsArticle({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) => NewsArticle(
    source: Source.fromJson(json["source"]),
    author: json["author"],
    title: json["title"] ?? 'Untitled',
    description: json["description"],
    url: json["url"] ?? '',
    urlToImage: json["urlToImage"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"],  // Nullable
  );

  Map<String, dynamic> toJson() => {
    "source": source.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt?.toIso8601String(),
    "content": content,
  };
}

class Source {
  String? id;
  String name;

  Source({
    this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"],
    name: json["name"] ?? 'Unknown',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

