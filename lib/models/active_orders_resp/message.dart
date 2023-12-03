class Message {
  var id;
  var senderId;
  var receiverId;
  var message;
  var createdAt;
  var updatedAt;
  var serviceRequestId;

  Message({
      this.id, 
      this.senderId, 
      this.receiverId, 
      this.message, 
      this.createdAt, 
      this.updatedAt, 
      this.serviceRequestId});

  Message.fromJson(dynamic json) {
    id = json["id"];
    senderId = json["sender_id"];
    receiverId = json["receiver_id"];
    message = json["message"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    serviceRequestId = json["service_request_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["sender_id"] = senderId;
    map["receiver_id"] = receiverId;
    map["message"] = message;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["service_request_id"] = serviceRequestId;
    return map;
  }

}