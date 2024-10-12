
import 'dart:convert';

TopHeadlinesResponseModel topHeadlinesResponseModelFromJson(String str) => TopHeadlinesResponseModel.fromJson(json.decode(str));

String topHeadlinesResponseModelToJson(TopHeadlinesResponseModel data) => json.encode(data.toJson());

class TopHeadlinesResponseModel {
  String status;
  int totalResults;
  List<HeadlineArticle> articles;

  TopHeadlinesResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });


  factory TopHeadlinesResponseModel.fromJson(Map<String, dynamic> json) => TopHeadlinesResponseModel(
    status: json["status"] ?? '',
    totalResults: json["totalResults"] ?? 0,
    articles: json["articles"] != null
        ? List<HeadlineArticle>.from(json["articles"].map((x) => HeadlineArticle.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class HeadlineArticle {
  Source source;
  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  HeadlineArticle({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory HeadlineArticle.fromJson(Map<String, dynamic> json) => HeadlineArticle(
    source: Source.fromJson(json["source"]),
    author: json["author"],
    title: json["title"] ?? 'Untitled',
    description: json["description"],
    url: json["url"] ?? '',
    urlToImage: json["urlToImage"],
    publishedAt: json["publishedAt"] != null
        ? DateTime.tryParse(json["publishedAt"])
        : null,
    content: json["content"],
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

