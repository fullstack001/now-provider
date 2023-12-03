/// id : 1
/// provider_id : "139"
/// user_id : null
/// payment_id : "ch_3JXNnFCiKsbMzZ4L0NOW7zTv"
/// amount : "21"
/// amount_captured : "2100"
/// status : "succeeded"
/// payment_method : "visa"
/// created_at : "2021-09-08T10:14:13.000000Z"
/// updated_at : "2021-09-08T10:14:13.000000Z"

class TransationListData {
  var id;
  var providerId;
  var userId;
  var paymentId;
  var amount;
  var amountCaptured;
  var status;
  var paymentMethod;
  var createdAt;
  var updatedAt;

  TransationListData({
      this.id, 
      this.providerId, 
      this.userId, 
      this.paymentId, 
      this.amount, 
      this.amountCaptured, 
      this.status, 
      this.paymentMethod, 
      this.createdAt, 
      this.updatedAt});

  TransationListData.fromJson(dynamic json) {
    id = json["id"];
    providerId = json["provider_id"];
    userId = json["user_id"];
    paymentId = json["payment_id"];
    amount = json["amount"];
    amountCaptured = json["amount_captured"];
    status = json["status"];
    paymentMethod = json["payment_method"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["provider_id"] = providerId;
    map["user_id"] = userId;
    map["payment_id"] = paymentId;
    map["amount"] = amount;
    map["amount_captured"] = amountCaptured;
    map["status"] = status;
    map["payment_method"] = paymentMethod;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }

}