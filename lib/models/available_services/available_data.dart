import 'available_service_data.dart';

/// current_page : 1
/// available_service_data : [{"id":11,"user_id":58,"address":"Pakistan Engineering Council PEC Regional Office Lahore ,Shershah Block Garden Town,Lahore,Pakistan","status":"PENDING","created_at":"2021-08-14T08:06:26.000000Z","updated_at":"2021-08-14T08:06:26.000000Z","time_slots":[{"id":25,"provider_schedule_id":7,"start":"00:00","end":"00:00","created_at":"2021-08-11T09:07:13.000000Z","updated_at":"2021-08-11T09:07:13.000000Z","pivot":{"service_request_id":11,"time_slot_id":25}}],"request_infos":[{"id":1,"service_request_id":11,"question_id":1,"option_id":11,"created_at":"2021-08-14T08:06:26.000000Z","updated_at":"2021-08-14T08:06:26.000000Z","question":{"id":1,"sub_service_id":1,"question":"What is Room size","created_at":"2021-08-09T06:40:24.000000Z","updated_at":"2021-08-09T06:40:24.000000Z"},"option":{"id":11,"question_id":1,"option":"20x20","created_at":"2021-08-09T07:14:00.000000Z","updated_at":"2021-08-09T07:14:00.000000Z"}},{"id":2,"service_request_id":11,"question_id":2,"option_id":4,"created_at":"2021-08-14T08:06:26.000000Z","updated_at":"2021-08-14T08:06:26.000000Z","question":{"id":2,"sub_service_id":1,"question":"What is Room Type","created_at":"2021-08-09T06:43:05.000000Z","updated_at":"2021-08-09T06:43:05.000000Z"},"option":{"id":4,"question_id":2,"option":"Twin","created_at":"2021-08-09T07:11:54.000000Z","updated_at":"2021-08-09T07:11:54.000000Z"}}]},{"id":14,"user_id":58,"address":"Pakistan Engineering Council PEC Regional Office Lahore, Shershah Block Garden Town, Lahore, Pakistan","status":"PENDING","created_at":"2021-08-14T08:19:30.000000Z","updated_at":"2021-08-14T08:19:30.000000Z","time_slots":[{"id":31,"provider_schedule_id":8,"start":"19:00","end":"19:00","created_at":"2021-08-11T09:07:13.000000Z","updated_at":"2021-08-11T09:07:13.000000Z","pivot":{"service_request_id":14,"time_slot_id":31}}],"request_infos":[{"id":5,"service_request_id":14,"question_id":1,"option_id":11,"created_at":"2021-08-14T08:19:30.000000Z","updated_at":"2021-08-14T08:19:30.000000Z","question":{"id":1,"sub_service_id":1,"question":"What is Room size","created_at":"2021-08-09T06:40:24.000000Z","updated_at":"2021-08-09T06:40:24.000000Z"},"option":{"id":11,"question_id":1,"option":"20x20","created_at":"2021-08-09T07:14:00.000000Z","updated_at":"2021-08-09T07:14:00.000000Z"}},{"id":6,"service_request_id":14,"question_id":2,"option_id":4,"created_at":"2021-08-14T08:19:30.000000Z","updated_at":"2021-08-14T08:19:30.000000Z","question":{"id":2,"sub_service_id":1,"question":"What is Room Type","created_at":"2021-08-09T06:43:05.000000Z","updated_at":"2021-08-09T06:43:05.000000Z"},"option":{"id":4,"question_id":2,"option":"Twin","created_at":"2021-08-09T07:11:54.000000Z","updated_at":"2021-08-09T07:11:54.000000Z"}}]}]
/// first_page_url : "https://api.farenow.com/api/provider/order?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://api.farenow.com/api/provider/order?page=1"
/// next_page_url : null
/// path : "https://api.farenow.com/api/provider/order"
/// per_page : 100
/// prev_page_url : null
/// to : 2
/// total : 2

class AvailableData {
  var currentPage;
  var availableServiceData;
  var firstPageUrl;
  var from;
  var lastPage;
  var lastPageUrl;
  dynamic nextPageUrl;
  var path;
  var perPage;
  dynamic prevPageUrl;
  var to;
  var total;

  AvailableData(
      {this.currentPage,
      this.availableServiceData,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  AvailableData.fromJson(dynamic json) {
    currentPage = json["current_page"];
    if (json["data"] != null) {
      availableServiceData = [];
      json["data"].forEach((v) {
        availableServiceData.add(AvailableServiceData.fromJson(v));
      });
    }
    firstPageUrl = json["first_page_url"];
    from = json["from"];
    lastPage = json["last_page"];
    lastPageUrl = json["last_page_url"];
    nextPageUrl = json["next_page_url"];
    path = json["path"];
    perPage = json["per_page"];
    prevPageUrl = json["prev_page_url"];
    to = json["to"];
    total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["current_page"] = currentPage;
    if (availableServiceData != null) {
      map["data"] = availableServiceData.map((v) => v.toJson()).toList();
    }
    map["first_page_url"] = firstPageUrl;
    map["from"] = from;
    map["last_page"] = lastPage;
    map["last_page_url"] = lastPageUrl;
    map["next_page_url"] = nextPageUrl;
    map["path"] = path;
    map["per_page"] = perPage;
    map["prev_page_url"] = prevPageUrl;
    map["to"] = to;
    map["total"] = total;
    return map;
  }
}
