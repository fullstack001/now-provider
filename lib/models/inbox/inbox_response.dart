

import 'package:fare_now_provider/models/inbox/data.dart';

/// error : false
/// data : {"current_page":1,"inbox_data":[{"id":77,"first_name":"Aurangzaib","last_name":"Rana","email":"aurangzaib@gmail.com","phone":"+923041417943","zip_code":"45368","role":"USER","status":"ACTIVE","created_at":"2021-08-23T09:28:39.000000Z","updated_at":"2021-08-23T09:28:39.000000Z","phone_verification":0,"provider_type":"Individual","account_type":"BASIC","receiver_message":{"id":53,"sender_id":139,"receiver_id":77,"message":"hello hello hello","created_at":"2021-09-09T11:55:25.000000Z","updated_at":"2021-09-09T11:55:25.000000Z"}},{"id":134,"first_name":"Azy","last_name":"Rana","email":"azy1@gmail.com","phone":"+16506492638","zip_code":"11101, 98031","role":"PROVIDER","status":"ACTIVE","created_at":"2021-08-29T13:48:10.000000Z","updated_at":"2021-08-29T13:50:36.000000Z","phone_verification":1,"spend_each_month":"$100 - $400","provider_type":"Individual","image":"/storage/provider/profile/612b90ac0e7f7-1630245036.jpg","bio":"I am Azy. I've been working for a long time.","account_type":"BASIC","receiver_message":{"id":45,"sender_id":139,"receiver_id":134,"message":"hello","created_at":"2021-09-09T11:20:57.000000Z","updated_at":"2021-09-09T11:20:57.000000Z"}},{"id":135,"first_name":"Aurangzaib","last_name":"Rana","email":"azy2@gmail.com","phone":"+16506492638","zip_code":"4545","role":"USER","status":"ACTIVE","created_at":"2021-08-29T13:54:58.000000Z","updated_at":"2021-08-29T13:54:58.000000Z","phone_verification":0,"provider_type":"Individual","bio":"I am Aurangzaib Rana and seeking services for years","account_type":"BASIC","receiver_message":{"id":51,"sender_id":139,"receiver_id":135,"message":"hello","created_at":"2021-09-09T11:35:33.000000Z","updated_at":"2021-09-09T11:35:33.000000Z"}},{"id":139,"first_name":"nouman","last_name":"amin","email":"noumanamin33@gmail.com","phone":"+923008383978","zip_code":"05724-005","role":"PROVIDER","status":"ACTIVE","created_at":"2021-08-31T06:13:31.000000Z","updated_at":"2021-09-09T03:50:44.000000Z","phone_verification":1,"spend_each_month":"$1 - $100","provider_type":"Business","image":"/storage/provider/profile/612dcb1468e3c-1630391060.jpg","bio":"abc abc abc back back abac back abac back back back back back back back bacb","account_type":"PREMIUM","device_token":"fAT_mkRVS46aYj7iNVQfri:APA91bFLeT5IOQOBEpF2Ag4LU5w-RxzcOm0WgRnWW4kpavMGN0D5jtTEgsSNmMLG-isz3FZl4ENEwz6-z17LLnKrSf_SAj4UTPHckqo8kNtxqtWwGHSithKENnPYOmCxW-MwKM-J3GW5","credit":"1650","sender_message":{"id":53,"sender_id":139,"receiver_id":77,"message":"hello hello hello","created_at":"2021-09-09T11:55:25.000000Z","updated_at":"2021-09-09T11:55:25.000000Z"},"receiver_message":{"id":41,"sender_id":139,"receiver_id":139,"message":"hello friend","created_at":"2021-09-09T09:11:57.000000Z","updated_at":"2021-09-09T09:11:57.000000Z"}},{"id":140,"first_name":"Nouman","last_name":"Amin","email":"amin@gmail.com","phone":"+923008383978","zip_code":"23423","role":"USER","status":"ACTIVE","created_at":"2021-08-31T10:09:16.000000Z","updated_at":"2021-09-09T03:56:37.000000Z","phone_verification":0,"provider_type":"Individual","image":"/storage/user/profile/6130abd95eb06-1630579673.jpg","bio":"Sadjkfkjsd fkjsdhfiodjujiasd kasudi","account_type":"BASIC","device_token":"dzErceucRDqxvc91IfYvt8:APA91bEfEdrogWuqhCf9fc8Y1PgJD8LeBJgqneLz4kMktd8aaodJngOfchPrMQcV-uC8UseI4Kyu2XALLieZRyPOQL5rPfrFdWc9UpGPSOAJJZHKY14C8QaRMrTqObRKfLNTAGE45sC2","sender_message":{"id":40,"sender_id":140,"receiver_id":139,"message":"hi my name is nouman","created_at":"2021-09-09T08:17:33.000000Z","updated_at":"2021-09-09T08:17:33.000000Z"},"receiver_message":{"id":52,"sender_id":139,"receiver_id":140,"message":"hello","created_at":"2021-09-09T11:54:32.000000Z","updated_at":"2021-09-09T11:54:32.000000Z"}}],"first_page_url":"https://api.farenow.com/api/user/message?page=1","from":1,"last_page":1,"last_page_url":"https://api.farenow.com/api/user/message?page=1","path":"https://api.farenow.com/api/user/message","per_page":20,"to":5,"total":5}
/// message : "OK"

class InboxResponse {
  var error;
  var data;
  var message;

  InboxResponse({
      this.error, 
      this.data, 
      this.message});

  InboxResponse.fromJson(dynamic json) {
    error = json["error"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (data != null) {
      map["data"] = data.toJson();
    }
    map["message"] = message;
    return map;
  }

}