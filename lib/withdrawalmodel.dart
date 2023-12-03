
import 'dart:convert';

WithdrawalModel withdrawalModelFromMap(String str) => WithdrawalModel.fromMap(json.decode(str));

String withdrawalModelToMap(WithdrawalModel data) => json.encode(data.toMap());

class WithdrawalModel {
  WithdrawalModel({
    this.error,
    this.message,
  });

  var error;
  var message;

  factory WithdrawalModel.fromMap(Map<String, dynamic> json) => WithdrawalModel(
    error: json["error"] == null ? null : json["error"],
    message: json["message"] == null ? null : json["message"],//Message.fromMap(json["message"]),
  );

  Map<String, dynamic> toMap() => {
    "error": error == null ? null : error,
    "message": message == null ? null : message.toMap(),
  };
}


