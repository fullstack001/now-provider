// To parse this JSON data, do
//
//     final packagePlanDetails = packagePlanDetailsFromJson(jsonString);

import 'dart:convert';

PackagePlanDetails packagePlanDetailsFromJson(String str) =>
    PackagePlanDetails.fromJson(json.decode(str));

String packagePlanDetailsToJson(PackagePlanDetails data) =>
    json.encode(data.toJson());

class PackagePlanDetails {
  PackagePlanDetails({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  List<Datum>? data;

  factory PackagePlanDetails.fromJson(Map<String, dynamic> json) =>
      PackagePlanDetails(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.providerId,
    this.title,
    this.stripeId,
    this.stripeName,
    this.price,
    this.credit,
    this.type,
    this.duration,
    this.off,
    this.threshold,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  int? providerId;
  String? title;
  dynamic stripeId;
  dynamic stripeName;
  String? price;
  dynamic credit;
  String? type;
  int? duration;
  int? off;
  dynamic threshold;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        title: json["title"] == null ? null : json["title"],
        stripeId: json["stripe_id"],
        stripeName: json["stripe_name"],
        price: json["price"] == null ? null : json["price"],
        credit: json["credit"],
        type: json["type"] == null ? null : json["type"],
        duration: json["duration"] == null ? null : json["duration"],
        off: json["off"] == null ? null : json["off"],
        threshold: json["threshold"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "title": title == null ? null : title,
        "stripe_id": stripeId,
        "stripe_name": stripeName,
        "price": price == null ? null : price,
        "credit": credit,
        "type": type == null ? null : type,
        "duration": duration == null ? null : duration,
        "off": off == null ? null : off,
        "threshold": threshold,
        "description": description == null ? null : description,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
