/// provider_id : 139
/// payment_id : "ch_3JXOETCiKsbMzZ4L0PDyebvz"
/// amount : "100"
/// amount_captured : 10000
/// status : "succeeded"
/// payment_method : "visa"
/// updated_at : "2021-09-08T10:42:21.000000Z"
/// created_at : "2021-09-08T10:42:21.000000Z"
/// id : 5

class BuyCreditData {
  var providerId;
  var paymentId;
  var amount;
  var amountCaptured;
  var status;
  var paymentMethod;
  var updatedAt;
  var createdAt;
  var id;

  BuyCreditData({
      this.providerId, 
      this.paymentId, 
      this.amount, 
      this.amountCaptured, 
      this.status, 
      this.paymentMethod, 
      this.updatedAt, 
      this.createdAt, 
      this.id});

  BuyCreditData.fromJson(dynamic json) {
    providerId = json["provider_id"];
    paymentId = json["payment_id"];
    amount = json["amount"];
    amountCaptured = json["amount_captured"];
    status = json["status"];
    paymentMethod = json["payment_method"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["provider_id"] = providerId;
    map["payment_id"] = paymentId;
    map["amount"] = amount;
    map["amount_captured"] = amountCaptured;
    map["status"] = status;
    map["payment_method"] = paymentMethod;
    map["updated_at"] = updatedAt;
    map["created_at"] = createdAt;
    map["id"] = id;
    return map;
  }

}