// To parse this JSON data, do
//
//     final mediaPostList = mediaPostListFromJson(jsonString);

import 'dart:convert';

MediaPostList mediaPostListFromJson(String str) =>
    MediaPostList.fromJson(json.decode(str));

String mediaPostListToJson(MediaPostList data) => json.encode(data.toJson());

class MediaPostList {
  MediaPostList({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory MediaPostList.fromJson(Map<String, dynamic> json) => MediaPostList(
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
    required this.memberId,
    required this.desription,
    required this.image,
    required this.video,
    required this.createdAt,
  });

  int id;
  int memberId;
  String desription;
  String image;
  String video;
  DateTime createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        memberId: json["member_id"],
        desription: json["desription"],
        image: json["image"],
        video: json["video"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "member_id": memberId,
        "desription": desription,
        "image": image,
        "video": video,
        "created_at": createdAt.toIso8601String(),
      };
}
