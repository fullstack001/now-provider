/// id : 53
/// sender_id : 139
/// receiver_id : 77
/// message : "hello hello hello"
/// created_at : "2021-09-09T11:55:25.000000Z"
/// updated_at : "2021-09-09T11:55:25.000000Z"

class ReceiverMessage {
  var id;
  var senderId;
  var receiverId;
  var message;
  var createdAt;
  var updatedAt;

  ReceiverMessage({
      this.id, 
      this.senderId, 
      this.receiverId, 
      this.message, 
      this.createdAt, 
      this.updatedAt});

  ReceiverMessage.fromJson(dynamic json) {
    id = json["id"];
    senderId = json["sender_id"];
    receiverId = json["receiver_id"];
    message = json["message"];
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