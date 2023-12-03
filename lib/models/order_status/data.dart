import 'worked_times.dart';

class Data {
  var id;
  var userId;
  var address;
  var status;
  var createdAt;
  var updatedAt;
  var providerId;
  var quotationInfoId;
  dynamic hours;
  var isQuotation;
  var directContact;
  var isReplied;
  var isPaused;
  var isCompleted;
  dynamic workedHours;
  var workedTimes;

  Data({
    this.id,
    this.userId,
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
    this.workedTimes,
    this.isPaused,
  });

  Data.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
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
    isPaused = json["working_status"] == "STARTED" ? 0 : 1;
    workedHours = json["worked_hours"];
    if (json["worked_times"] != null) {
      workedTimes = [];
      json["worked_times"].forEach((v) {
        workedTimes.add(WorkedTimes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
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
    map["is_paused"] = isPaused;
    if (workedTimes != null) {
      map["worked_times"] = workedTimes.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
