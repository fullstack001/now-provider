class MovingQuotationInfo {
  var id;
  dynamic vehicleTypeId;
  var detail;
  dynamic reply;
  dynamic duration;
  dynamic price;
  var phone;
  var email;
  var name;
  var fromAddress;
  var startLat;
  var startLng;
  var toAddress;
  var endLat;
  var endLng;
  var date;
  var createdAt;
  var updatedAt;
  var quotationMedia;

  MovingQuotationInfo({
      this.id, 
      this.vehicleTypeId, 
      this.detail, 
      this.reply, 
      this.duration, 
      this.price, 
      this.phone, 
      this.email, 
      this.name, 
      this.fromAddress, 
      this.startLat, 
      this.startLng, 
      this.toAddress, 
      this.endLat, 
      this.endLng, 
      this.date, 
      this.createdAt, 
      this.updatedAt, 
      this.quotationMedia});

  MovingQuotationInfo.fromJson(dynamic json) {
    id = json["id"];
    vehicleTypeId = json["vehicle_type_id"];
    detail = json["detail"];
    reply = json["reply"];
    duration = json["duration"];
    price = json["price"];
    phone = json["phone"];
    email = json["email"];
    name = json["name"];
    fromAddress = json["from_address"];
    startLat = json["start_lat"];
    startLng = json["start_lng"];
    toAddress = json["to_address"];
    endLat = json["end_lat"];
    endLng = json["end_lng"];
    date = json["date"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["vehicle_type_id"] = vehicleTypeId;
    map["detail"] = detail;
    map["reply"] = reply;
    map["duration"] = duration;
    map["price"] = price;
    map["phone"] = phone;
    map["email"] = email;
    map["name"] = name;
    map["from_address"] = fromAddress;
    map["start_lat"] = startLat;
    map["start_lng"] = startLng;
    map["to_address"] = toAddress;
    map["end_lat"] = endLat;
    map["end_lng"] = endLng;
    map["date"] = date;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;

    return map;
  }

}