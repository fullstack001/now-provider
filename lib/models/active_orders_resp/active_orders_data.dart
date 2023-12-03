import 'message.dart';

class ActiveOrdersData {
  var id;
  var userId;
  dynamic subServiceId;
  var address;
  var status;
  var createdAt;
  var updatedAt;
  var providerId;
  dynamic quotationInfoId;
  var hours;
  var isQuotation;
  var directContact;
  var isReplied;
  var isCompleted;
  dynamic workedHours;
  dynamic workingStatus;
  var subService;
  dynamic paymentStatus;
  var paidAmount;
  dynamic payableAmount;
  dynamic type;
  dynamic provider;
  var message;
  var seconds;
  var verifiedAt;

  ActiveOrdersData(
      {this.id,
      this.userId,
      this.subServiceId,
      this.address,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.providerId,
      this.quotationInfoId,
      this.hours,
      this.isQuotation,
      this.directContact,
      this.isReplied,
      this.isCompleted,
      this.workedHours,
      this.workingStatus,
      this.subService,
      this.paymentStatus,
      this.paidAmount,
      this.payableAmount,
      this.type,
      this.provider,
      this.message,
      this.verifiedAt});

  ActiveOrdersData.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    subServiceId = json["sub_service_id"];
    address = json["address"];
    status = json["status"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    providerId = json["provider_id"];
    quotationInfoId = json["quotation_info_id"];
    hours = json["hours"];
    isQuotation = json["is_quotation"];
    directContact = json["direct_contact"];
    isReplied = json["is_replied"];
    isCompleted = json["is_completed"];
    workedHours = json["worked_hours"];
    workingStatus = json["working_status"];
    subService = json["sub_service"];
    paymentStatus = json["payment_status"];
    paidAmount = json["paid_amount"];
    payableAmount = json["payable_amount"];
    type = json["type"];
    provider = json["user"];
    // verifiedAt = provider["user"]["verified_at"] == null
    //     ? null
    //     : provider["user"]["verified_at"];
    message =
        json["message"] != null ? Message.fromJson(json["message"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
    map["sub_service_id"] = subServiceId;
    map["address"] = address;
    map["status"] = status;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["provider_id"] = providerId;
    map["quotation_info_id"] = quotationInfoId;
    map["hours"] = hours;
    map["is_quotation"] = isQuotation;
    map["direct_contact"] = directContact;
    map["is_replied"] = isReplied;
    map["is_completed"] = isCompleted;
    map["worked_hours"] = workedHours;
    map["working_status"] = workingStatus;
    map["sub_service"] = subService;
    map["payment_status"] = paymentStatus;
    map["paid_amount"] = paidAmount;
    map["payable_amount"] = payableAmount;
    map["type"] = type;
    map["provider"] = provider;
    if (message != null) {
      map["message"] = message.toJson();
    }
    return map;
  }
}
