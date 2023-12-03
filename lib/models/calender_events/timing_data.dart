import 'package:fare_now_provider/models/calender_events/timing_dates_data.dart';

/// current_page : 1
/// timing_dates_data : [{"id":4,"provider_id":48,"year":"2021","month":"8","date":"5","created_at":"2021-08-10T13:29:53.000000Z","updated_at":"2021-08-10T13:29:53.000000Z","time_slots":[{"id":7,"provider_schedule_id":4,"start":"00","end":"01","created_at":"2021-08-10T13:29:53.000000Z","updated_at":"2021-08-10T13:29:53.000000Z"},{"id":8,"provider_schedule_id":4,"start":"02","end":"03","created_at":"2021-08-10T13:29:53.000000Z","updated_at":"2021-08-10T13:29:53.000000Z"}]},{"id":5,"provider_id":48,"year":"2021","month":"8","date":"6","created_at":"2021-08-10T13:29:53.000000Z","updated_at":"2021-08-10T13:29:53.000000Z","time_slots":[{"id":9,"provider_schedule_id":5,"start":"00","end":"01","created_at":"2021-08-10T13:29:53.000000Z","updated_at":"2021-08-10T13:29:53.000000Z"},{"id":10,"provider_schedule_id":5,"start":"02","end":"03","created_at":"2021-08-10T13:29:53.000000Z","updated_at":"2021-08-10T13:29:53.000000Z"}]},{"id":1,"provider_id":48,"year":"2021","month":"1","date":"5","created_at":"2021-08-10T13:16:00.000000Z","updated_at":"2021-08-10T13:16:00.000000Z","time_slots":[{"id":1,"provider_schedule_id":1,"start":"00","end":"01","created_at":"2021-08-10T13:16:00.000000Z","updated_at":"2021-08-10T13:16:00.000000Z"},{"id":2,"provider_schedule_id":1,"start":"00","end":"01","created_at":"2021-08-10T13:16:00.000000Z","updated_at":"2021-08-10T13:16:00.000000Z"}]},{"id":2,"provider_id":48,"year":"2021","month":"1","date":"6","created_at":"2021-08-10T13:16:00.000000Z","updated_at":"2021-08-10T13:16:00.000000Z","time_slots":[{"id":3,"provider_schedule_id":2,"start":"00","end":"01","created_at":"2021-08-10T13:16:00.000000Z","updated_at":"2021-08-10T13:16:00.000000Z"},{"id":4,"provider_schedule_id":2,"start":"00","end":"01","created_at":"2021-08-10T13:16:00.000000Z","updated_at":"2021-08-10T13:16:00.000000Z"}]},{"id":3,"provider_id":48,"year":"2021","month":"1","date":"7","created_at":"2021-08-10T13:16:00.000000Z","updated_at":"2021-08-10T13:16:00.000000Z","time_slots":[{"id":5,"provider_schedule_id":3,"start":"00","end":"01","created_at":"2021-08-10T13:16:00.000000Z","updated_at":"2021-08-10T13:16:00.000000Z"},{"id":6,"provider_schedule_id":3,"start":"00","end":"01","created_at":"2021-08-10T13:16:00.000000Z","updated_at":"2021-08-10T13:16:00.000000Z"}]}]
/// first_page_url : "https://api.farenow.com/api/provider/services/schedulepage=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://api.farenow.com/api/provider/services/schedulepage=1"
/// next_page_url : null
/// path : "https://api.farenow.com/api/provider/services/schedule"
/// per_page : 100
/// prev_page_url : null
/// to : 5
/// total : 5

class TimingData {
  var currentPage;
  var timingDatesData;
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

  TimingData(
      {this.currentPage,
      this.timingDatesData,
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

  TimingData.fromJson(dynamic json) {
    currentPage = json["current_page"];
    if (json["data"] != null) {
      timingDatesData = [];
      json["data"].forEach((v) {
        timingDatesData.add(TimingDatesData.fromJson(v));
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
    if (timingDatesData != null) {
      map["data"] = timingDatesData.map((v) => v.toJson()).toList();
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
