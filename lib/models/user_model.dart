// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.status,
    required this.message,
    required this.detail,
  });

  int status;
  String message;
  List<Detail> detail;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        message: json["message"],
        detail:
            List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    required this.id,
    required this.status,
    required this.image,
    required this.fullName,
    required this.whatsappNumber,
    required this.emailId,
    required this.dateOfBirth,
    required this.gender,
    this.residenceAdress,
    required this.areaOfResidenceAdress,
    this.pincode,
    this.markAsPresident,
    required this.referralCode,
    required this.parentRefrealCode,
    required this.point,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String status;
  String image;
  String fullName;
  int whatsappNumber;
  String emailId;
  DateTime dateOfBirth;
  String gender;
  dynamic residenceAdress;
  String areaOfResidenceAdress;
  dynamic pincode;
  dynamic markAsPresident;
  String referralCode;
  String parentRefrealCode;
  int point;
  DateTime createdAt;
  DateTime updatedAt;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        status: json["status"],
        image: json["image"],
        fullName: json["full_name"],
        whatsappNumber: json["whatsapp_number"],
        emailId: json["email_id"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        residenceAdress: json["residence_adress"],
        areaOfResidenceAdress: json["area_of_residence_adress"],
        pincode: json["pincode"],
        markAsPresident: json["mark_as_president"],
        referralCode: json["referral_code"],
        parentRefrealCode: json["parent_refreal_code"],
        point: json["point"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "image": image,
        "full_name": fullName,
        "whatsapp_number": whatsappNumber,
        "email_id": emailId,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "residence_adress": residenceAdress,
        "area_of_residence_adress": areaOfResidenceAdress,
        "pincode": pincode,
        "mark_as_president": markAsPresident,
        "referral_code": referralCode,
        "parent_refreal_code": parentRefrealCode,
        "point": point,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
