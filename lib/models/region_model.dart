// To parse this JSON data, do
//
//     final regionModel = regionModelFromJson(jsonString);

import 'dart:convert';

RegionModel regionModelFromJson(String str) => RegionModel.fromJson(json.decode(str));

String regionModelToJson(RegionModel data) => json.encode(data.toJson());

class RegionModel {
    RegionModel({
        required this.status,
        required this.message,
        required this.data,
    });

    int status;
    String message;
    List<RegionDatum> data;

    factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        status: json["status"],
        message: json["message"],
        data: List<RegionDatum>.from(json["Data"].map((x) => RegionDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class RegionDatum {
    RegionDatum({
        required this.id,
        required this.regionTitle,
        this.pincode,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String regionTitle;
    String? pincode;
    Status status;
    DateTime createdAt;
    DateTime updatedAt;

    factory RegionDatum.fromJson(Map<String, dynamic> json) => RegionDatum(
        id: json["id"],
        regionTitle: json["region_title"],
        pincode: json["pincode"],
        status: statusValues.map[json["status"]]!,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "region_title": regionTitle,
        "pincode": pincode,
        "status": statusValues.reverse[status],
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

enum Status { ACTIVE }

final statusValues = EnumValues({
    "active": Status.ACTIVE
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
