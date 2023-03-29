// To parse this JSON data, do
//
//     final servicesListModel = servicesListModelFromJson(jsonString);

import 'dart:convert';

ServicesListModel servicesListModelFromJson(String str) =>
    ServicesListModel.fromJson(json.decode(str));

String servicesListModelToJson(ServicesListModel data) =>
    json.encode(data.toJson());

class ServicesListModel {
  ServicesListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<ServicesDatum> data;

  factory ServicesListModel.fromJson(Map<String, dynamic> json) =>
      ServicesListModel(
        status: json["status"],
        message: json["message"],
        data: List<ServicesDatum>.from(
            json["Data"].map((x) => ServicesDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ServicesDatum {
  ServicesDatum({
    required this.id,
    required this.status,
    this.image,
    required this.fullName,
    required this.whatsappNo,
    required this.emailId,
    required this.companyName,
    required this.businessCategory,
    required this.region,
    required this.pincode,
    this.markAsPresident,
    required this.referralCode,
    required this.createdAt,
    required this.updatedAt,
    required this.categoriesName,
    this.averageRating,
  });

  int id;
  String status;
  String? image;
  String fullName;
  String whatsappNo;
  String emailId;
  String companyName;
  String businessCategory;
  String region;
  int pincode;
  int? markAsPresident;
  String referralCode;
  DateTime createdAt;
  DateTime updatedAt;
  String categoriesName;
  dynamic averageRating;

  factory ServicesDatum.fromJson(Map<String, dynamic> json) => ServicesDatum(
        id: json["id"],
        status: json["status"],
        image: json["image"],
        fullName: json["full_name"],
        whatsappNo: json["whatsapp_no"],
        emailId: json["email_id"],
        companyName: json["company_name"],
        businessCategory: json["business_category"],
        region: json["region"],
        pincode: json["pincode"],
        markAsPresident: json["mark_as_president"],
        referralCode: json["referral_code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categoriesName: json["categories_name"],
        averageRating: json["AverageRating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "image": image,
        "full_name": fullName,
        "whatsapp_no": whatsappNo,
        "email_id": emailId,
        "company_name": companyName,
        "business_category": businessCategory,
        "region": region,
        "pincode": pincode,
        "mark_as_president": markAsPresident,
        "referral_code": referralCode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "categories_name": categoriesName,
        "AverageRating": averageRating,
      };
}
