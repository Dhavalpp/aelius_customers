// To parse this JSON data, do
//
//     final BannerListModel = BannerListModelFromJson(jsonString);

import 'dart:convert';

BannerListModel BannerListModelFromJson(String str) =>
    BannerListModel.fromJson(json.decode(str));

String BannerListModelToJson(BannerListModel data) =>
    json.encode(data.toJson());

class BannerListModel {
  BannerListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory BannerListModel.fromJson(Map<String, dynamic> json) =>
      BannerListModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.bannerFor,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  int id;
  String bannerFor;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        bannerFor: json["banner_for"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "banner_for": bannerFor,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
      };
}
