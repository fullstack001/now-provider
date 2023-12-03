import 'package:fare_now_provider/models/available_services/moving_quotation_info.dart';
import 'package:fare_now_provider/models/available_services/quotation_info.dart';
import 'package:fare_now_provider/models/available_services/user_data_model.dart';
import 'package:fare_now_provider/models/order_status/worked_times.dart';

import 'request_infos.dart';
import 'time_slots.dart';

/// id : 11
/// user_id : 58
/// address : "Pakistan Engineering Council PEC Regional Office Lahore ,Shershah Block Garden Town,Lahore,Pakistan"
/// status : "PENDING"
/// created_at : "2021-08-14T08:06:26.000000Z"
/// updated_at : "2021-08-14T08:06:26.000000Z"
/// time_slots : [{"id":25,"provider_schedule_id":7,"start":"00:00","end":"00:00","created_at":"2021-08-11T09:07:13.000000Z","updated_at":"2021-08-11T09:07:13.000000Z","pivot":{"service_request_id":11,"time_slot_id":25}}]
/// request_infos : [{"id":1,"service_request_id":11,"question_id":1,"option_id":11,"created_at":"2021-08-14T08:06:26.000000Z","updated_at":"2021-08-14T08:06:26.000000Z","question":{"id":1,"sub_service_id":1,"question":"What is Room size","created_at":"2021-08-09T06:40:24.000000Z","updated_at":"2021-08-09T06:40:24.000000Z"},"option":{"id":11,"question_id":1,"option":"20x20","created_at":"2021-08-09T07:14:00.000000Z","updated_at":"2021-08-09T07:14:00.000000Z"}},{"id":2,"service_request_id":11,"question_id":2,"option_id":4,"created_at":"2021-08-14T08:06:26.000000Z","updated_at":"2021-08-14T08:06:26.000000Z","question":{"id":2,"sub_service_id":1,"question":"What is Room Type","created_at":"2021-08-09T06:43:05.000000Z","updated_at":"2021-08-09T06:43:05.000000Z"},"option":{"id":4,"question_id":2,"option":"Twin","created_at":"2021-08-09T07:11:54.000000Z","updated_at":"2021-08-09T07:11:54.000000Z"}}]

class AvailableServiceData {
  var id;
  var userId;
  var address;
  var status;
  var createdAt;
  var updatedAt;
  var quotationInfoId;
  var user;
  var quotationInfo;
  var timeSlots;
  var requestInfos;
  var directContact;
  var isReplied;
  var providerId;
  var isCompleted;
  var seconds;
  var workingStatus;
  var loading = false;

  var hours;
  var workedHours;
  var subService;
  var paymentStatus;
  var paidAmount;
  var payableAmount;
  var workedTimes;
  var isPaused = false;
  var type;
  var movingQuotationInfo;

  AvailableServiceData(
      {this.id,
      this.userId,
      this.address,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.timeSlots,
      this.requestInfos,
      this.user,
      this.quotationInfoId,
      this.quotationInfo,
      this.directContact,
      this.isReplied,
      this.providerId,
      this.isCompleted,
      this.seconds,
      this.workingStatus,
      this.hours,
      this.subService,
      this.paidAmount,
      this.payableAmount,
      this.paymentStatus,
      this.workedHours,
      this.type,
      this.workedTimes});

  AvailableServiceData.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    address = json["address"];
    status = json["status"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    quotationInfoId = json["quotation_info_id"];
    directContact = json["direct_contact"];
    isReplied = json["is_replied"];
    providerId = json["provider_id"];
    isCompleted = json["is_completed"];
    type = json["type"];
    seconds = json["seconds"];
    workingStatus = json["working_status"];
    if (json["worked_times"] != null) {
      workedTimes = [];
      json["worked_times"].forEach((v) {
        workedTimes.add(WorkedTimes.fromJson(v));
      });
    }
    hours = json["hours"];
    workedHours = json["worked_hours"];
    paymentStatus = json["payment_status"];
    paidAmount = json["paid_amount"];
    payableAmount = json["payable_amount"];
    subService = json["sub_service"];
    type = json["type"];
    movingQuotationInfo = json["quotation_info"] != null
        ? MovingQuotationInfo.fromJson(json["quotation_info"])
        : null;
    user = json["user"] == null
        ? UserDataModel()
        : UserDataModel.fromJson(json['user']);
    quotationInfo = json["quotation_info"] == null
        ? null
        : QuotationInfo.fromJson(json['quotation_info']);
    if (json["time_slots"] != null) {
      timeSlots = [];
      json["time_slots"].forEach((v) {
        timeSlots.add(TimeSlots.fromJson(v));
      });
    }
    if (json["request_infos"] != null) {
      requestInfos = [];
      json["request_infos"].forEach((v) {
        requestInfos.add(RequestInfos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["direct_contact"] = directContact;
    map["is_replied"] = isReplied;
    map["seconds"] = seconds;
    map["provider_id"] = providerId;
    map["is_completed"] = isCompleted;
    map["user_id"] = userId;
    map["address"] = address;
    map["status"] = status;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["quotation_info_id"] = quotationInfoId;
    map["quotation_info"] = quotationInfo;
    map["user"] = user;
    map["working_status"] = workingStatus;
    if (movingQuotationInfo != null) {
      map["quotation_info"] = movingQuotationInfo.toJson();
    }
    if (workedTimes != null) {
      map["worked_times"] = workedTimes.map((v) => v.toJson()).toList();
    }
    map["hours"] = hours;
    map["worked_hours"] = workedHours;
    map["payment_status"] = paymentStatus;
    map["paid_amount"] = paidAmount;
    map["payable_amount"] = payableAmount;
    map["sub_service"] = subService;

    if (timeSlots != null) {
      map["time_slots"] = timeSlots.map((v) => v.toJson()).toList();
    }
    if (requestInfos != null) {
      map["request_infos"] = requestInfos.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
