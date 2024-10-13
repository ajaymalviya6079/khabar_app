
import 'dart:convert';

CategoryResponseModel categoryResponseModelFromJson(String str) => CategoryResponseModel.fromJson(json.decode(str));

String categoryResponseModelToJson(CategoryResponseModel data) => json.encode(data.toJson());

class CategoryResponseModel {
  String status;
  List<Source> sources;

  CategoryResponseModel({
    required this.status,
    required this.sources,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) => CategoryResponseModel(
    status: json["status"],
    sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
  };
}

class Source {
  String id;
  String name;
  String description;
  String url;
  Category category;
  String language;
  String country;

  Source({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    url: json["url"],
    category: categoryValues.map[json["category"]]!,
    language: json["language"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "url": url,
    "category": categoryValues.reverse[category],
    "language": language,
    "country": country,
  };
}

enum Category {
  BUSINESS,
  ENTERTAINMENT,
  GENERAL,
  HEALTH,
  SCIENCE,
  SPORTS,
  TECHNOLOGY
}

final categoryValues = EnumValues({
  "business": Category.BUSINESS,
  "entertainment": Category.ENTERTAINMENT,
  "general": Category.GENERAL,
  "health": Category.HEALTH,
  "science": Category.SCIENCE,
  "sports": Category.SPORTS,
  "technology": Category.TECHNOLOGY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
