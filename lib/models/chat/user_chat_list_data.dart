/// id : 4
/// sender_id : 140
/// receiver_id : 139
/// message : "message test"
/// created_at : "2021-09-09T03:45:41.000000Z"
/// updated_at : "2021-09-09T03:45:41.000000Z"
import 'dart:convert';

class UserChatListData {
  var id;
  var senderId;
  var receiverId;
  var message;
  var createdAt;
  var updatedAt;
  var senderDetail;
  var reciverDetail;

  UserChatListData(
      {this.id,
      this.senderId,
      this.receiverId,
      this.message,
      this.createdAt,
      this.senderDetail,
      this.reciverDetail,
      this.updatedAt});

  UserChatListData.fromJson(dynamic json) {
    id = json["id"];
    senderId = json["sender_id"];
    receiverId = json["receiver_id"];
    message = json["message"];
    senderDetail = SenderDetail.fromJson(json["sender"]);
    reciverDetail = ReciverDetail.fromJson(json["receiver"]);
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["sender_id"] = senderId;
    map["receiver_id"] = receiverId;
    map["message"] = message;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }
}

SenderDetail senderDetailFromJson(String str) =>
    SenderDetail.fromJson(json.decode(str));

String senderDetailToJson(SenderDetail data) => json.encode(data.toJson());

class SenderDetail {
  SenderDetail({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? image;

  factory SenderDetail.fromJson(Map<String, dynamic> json) => SenderDetail(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "image": image == null ? null : image,
      };
}

ReciverDetail reciverDetailFromJson(String str) =>
    ReciverDetail.fromJson(json.decode(str));

String reciverDetailToJson(ReciverDetail data) => json.encode(data.toJson());

class ReciverDetail {
  ReciverDetail({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? image;

  factory ReciverDetail.fromJson(Map<String, dynamic> json) => ReciverDetail(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "image": image == null ? null : image,
      };
}
