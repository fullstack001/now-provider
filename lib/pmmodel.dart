
import 'dart:convert';

PmModel pmModelFromJson(String str) => PmModel.fromJson(json.decode(str));

String pmModelToJson(PmModel data) => json.encode(data.toJson());

class PmModel {
  PmModel({
    this.error,
    this.message,
    this.data,
  });

  var error;
  var message;
  var data;

  factory PmModel.fromJson(Map<String, dynamic> json) => PmModel(
    error: json["error"] == null ? null : json["error"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error,
    "message": message == null ? null : message,
    "data": data == null ? null : data,
  };
}


