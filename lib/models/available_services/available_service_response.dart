import 'available_data.dart';

/// error : false
/// message : "success"
/// available_data : {"current_page":1,"available_service_data":[{"id":11,"user_id":58,"address":"Pakistan Engineering Council PEC Regional Office Lahore ,Shershah Block Garden Town,Lahore,Pakistan","status":"PENDING","created_at":"2021-08-14T08:06:26.000000Z","updated_at":"2021-08-14T08:06:26.000000Z","time_slots":[{"id":25,"provider_schedule_id":7,"start":"00:00","end":"00:00","created_at":"2021-08-11T09:07:13.000000Z","updated_at":"2021-08-11T09:07:13.000000Z","pivot":{"service_request_id":11,"time_slot_id":25}}],"request_infos":[{"id":1,"service_request_id":11,"question_id":1,"option_id":11,"created_at":"2021-08-14T08:06:26.000000Z","updated_at":"2021-08-14T08:06:26.000000Z","question":{"id":1,"sub_service_id":1,"question":"What is Room size","created_at":"2021-08-09T06:40:24.000000Z","updated_at":"2021-08-09T06:40:24.000000Z"},"option":{"id":11,"question_id":1,"option":"20x20","created_at":"2021-08-09T07:14:00.000000Z","updated_at":"2021-08-09T07:14:00.000000Z"}},{"id":2,"service_request_id":11,"question_id":2,"option_id":4,"created_at":"2021-08-14T08:06:26.000000Z","updated_at":"2021-08-14T08:06:26.000000Z","question":{"id":2,"sub_service_id":1,"question":"What is Room Type","created_at":"2021-08-09T06:43:05.000000Z","updated_at":"2021-08-09T06:43:05.000000Z"},"option":{"id":4,"question_id":2,"option":"Twin","created_at":"2021-08-09T07:11:54.000000Z","updated_at":"2021-08-09T07:11:54.000000Z"}}]},{"id":14,"user_id":58,"address":"Pakistan Engineering Council PEC Regional Office Lahore, Shershah Block Garden Town, Lahore, Pakistan","status":"PENDING","created_at":"2021-08-14T08:19:30.000000Z","updated_at":"2021-08-14T08:19:30.000000Z","time_slots":[{"id":31,"provider_schedule_id":8,"start":"19:00","end":"19:00","created_at":"2021-08-11T09:07:13.000000Z","updated_at":"2021-08-11T09:07:13.000000Z","pivot":{"service_request_id":14,"time_slot_id":31}}],"request_infos":[{"id":5,"service_request_id":14,"question_id":1,"option_id":11,"created_at":"2021-08-14T08:19:30.000000Z","updated_at":"2021-08-14T08:19:30.000000Z","question":{"id":1,"sub_service_id":1,"question":"What is Room size","created_at":"2021-08-09T06:40:24.000000Z","updated_at":"2021-08-09T06:40:24.000000Z"},"option":{"id":11,"question_id":1,"option":"20x20","created_at":"2021-08-09T07:14:00.000000Z","updated_at":"2021-08-09T07:14:00.000000Z"}},{"id":6,"service_request_id":14,"question_id":2,"option_id":4,"created_at":"2021-08-14T08:19:30.000000Z","updated_at":"2021-08-14T08:19:30.000000Z","question":{"id":2,"sub_service_id":1,"question":"What is Room Type","created_at":"2021-08-09T06:43:05.000000Z","updated_at":"2021-08-09T06:43:05.000000Z"},"option":{"id":4,"question_id":2,"option":"Twin","created_at":"2021-08-09T07:11:54.000000Z","updated_at":"2021-08-09T07:11:54.000000Z"}}]}],"first_page_url":"https://api.farenow.com/api/provider/orderpage=1","from":1,"last_page":1,"last_page_url":"https://api.farenow.com/api/provider/orderpage=1","next_page_url":null,"path":"https://api.farenow.com/api/provider/order","per_page":100,"prev_page_url":null,"to":2,"total":2}

class AvailableServiceResponse {
  var error;
  var message;
  var availableData;

  AvailableServiceResponse({
      this.error, 
      this.message, 
      this.availableData});

  AvailableServiceResponse.fromJson(dynamic json) {
    error = json["error"];
    message = json["message"];
    availableData = json["data"] != null ? AvailableData.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    map["message"] = message;
    if (availableData != null) {
      map["data"] = availableData.toJson();
    }
    return map;
  }

}