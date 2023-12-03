/// id : 2
/// detail : "sdfasfjlkajsduoiwuerskjflkfsj"
/// reply : "sdfsdfwerwer"
/// duration : "4 Hour"
/// price : "123"
/// created_at : "2021-08-22T02:55:29.000000Z"
/// updated_at : "2021-08-22T07:46:30.000000Z"

class QuotationInfo {
  var id;
  var detail;
  var reply;
  var duration;
  var price;
  var createdAt;
  var updatedAt;

  QuotationInfo({
      this.id, 
      this.detail, 
      this.reply, 
      this.duration, 
      this.price, 
      this.createdAt, 
      this.updatedAt});

  QuotationInfo.fromJson(dynamic json) {
    id = json["id"];
    detail = json["detail"];
    reply = json["reply"];
    duration = json["duration"];
    price = json["price"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["detail"] = detail;
    map["reply"] = reply;
    map["duration"] = duration;
    map["price"] = price;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }

}