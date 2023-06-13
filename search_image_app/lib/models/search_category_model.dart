// To parse this JSON data, do
//
//     final searchCategoryModel = searchCategoryModelFromJson(jsonString);

import 'dart:convert';

SearchCategoryModel searchCategoryModelFromJson(String str) => SearchCategoryModel.fromJson(json.decode(str));

String searchCategoryModelToJson(SearchCategoryModel data) => json.encode(data.toJson());

class SearchCategoryModel {
  String? message;
  List<SearchCategory>? data;
  String? status;

  SearchCategoryModel({
    this.message,
    this.data,
    this.status,
  });

  factory SearchCategoryModel.fromJson(Map<String, dynamic> json) => SearchCategoryModel(
    message: json["message"],
    data: json["data"] == null ? [] : List<SearchCategory>.from(json["data"]!.map((x) => SearchCategory.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
  };
}

class SearchCategory {
  String? category;
  String? imageUrl;
  List<String>? keywords;

  SearchCategory({
    this.category,
    this.imageUrl,
    this.keywords,
  });

  factory SearchCategory.fromJson(Map<String, dynamic> json) => SearchCategory(
    category: json["category"],
    imageUrl: json["imageUrl"],
    keywords: json["keywords"] == null ? [] : List<String>.from(json["keywords"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "imageUrl": imageUrl,
    "keywords": keywords == null ? [] : List<dynamic>.from(keywords!.map((x) => x)),
  };
}
