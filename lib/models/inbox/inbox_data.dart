import 'receiver_message.dart';

/// id : 77
/// first_name : "Aurangzaib"
/// last_name : "Rana"
/// email : "aurangzaib@gmail.com"
/// phone : "+923041417943"
/// zip_code : "45368"
/// role : "USER"
/// status : "ACTIVE"
/// created_at : "2021-08-23T09:28:39.000000Z"
/// updated_at : "2021-08-23T09:28:39.000000Z"
/// phone_verification : 0
/// provider_type : "Individual"
/// account_type : "BASIC"
/// receiver_message : {"id":53,"sender_id":139,"receiver_id":77,"message":"hello hello hello","created_at":"2021-09-09T11:55:25.000000Z","updated_at":"2021-09-09T11:55:25.000000Z"}

class InboxData {
  var id;
  var firstName;
  var lastName;
  var email;
  var phone;
  var zipCode;
  var role;
  var status;
  var createdAt;
  var image;
  var updatedAt;
  var phoneVerification;
  var providerType;
  var accountType;
  var receiverMessage;
  var senderMessage;

  InboxData({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.zipCode,
    this.role,
    this.status,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.phoneVerification,
    this.providerType,
    this.accountType,
    this.receiverMessage,
    this.senderMessage,
  });

  InboxData.fromJson(dynamic json) {
    id = json["id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    email = json["email"];
    phone = json["phone"];
    zipCode = json["zip_code"];
    role = json["role"];
    status = json["status"];
    createdAt = json["created_at"];
    image = json["image"];
    updatedAt = json["updated_at"];
    phoneVerification = json["phone_verification"];
    providerType = json["provider_type"];
    accountType = json["account_type"];
    receiverMessage = json["receiver_message"] != null
        ? ReceiverMessage.fromJson(json["receiver_message"])
        : null;
    senderMessage = json["sender_message"] != null
        ? ReceiverMessage.fromJson(json["sender_message"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["email"] = email;
    map["phone"] = phone;
    map["zip_code"] = zipCode;
    map["role"] = role;
    map["status"] = status;
    map["image"] = image;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["phone_verification"] = phoneVerification;
    map["provider_type"] = providerType;
    map["account_type"] = accountType;
    if (receiverMessage != null) {
      map["receiver_message"] = receiverMessage.toJson();
    }
    if (senderMessage != null) {
      map["sender_message"] = senderMessage.toJson();
    }
    return map;
  }
}
