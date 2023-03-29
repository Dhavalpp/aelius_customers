// To parse this JSON data, do
//
//     final rewardedModel = rewardedModelFromJson(jsonString);

import 'dart:convert';

RewardedModel rewardedModelFromJson(String str) =>
    RewardedModel.fromJson(json.decode(str));

String rewardedModelToJson(RewardedModel data) => json.encode(data.toJson());

class RewardedModel {
  RewardedModel({
    required this.status,
    required this.message,
    required this.total,
    required this.data,
  });

  int status;
  String message;
  String total;
  List<Datum> data;

  factory RewardedModel.fromJson(Map<String, dynamic> json) => RewardedModel(
        status: json["status"],
        message: json["message"],
        total: json["Total"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Total": total,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.referralCode,
    required this.parentReferralCode,
    required this.point,
    required this.description,
    required this.createdAt,
  });

  int id;
  String name;
  String referralCode;
  String parentReferralCode;
  int point;
  String description;
  DateTime createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        referralCode: json["referral_code"],
        parentReferralCode: json["parent_referral_code"],
        point: json["point"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "referral_code": referralCode,
        "parent_referral_code": parentReferralCode,
        "point": point,
        "description": description,
        "created_at": createdAt.toIso8601String(),
      };
}
