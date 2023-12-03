import 'transation_data.dart';

/// error : false
/// transation_data : {"current_page":1,"transation_list_data":[{"id":1,"provider_id":"139","user_id":null,"payment_id":"ch_3JXNnFCiKsbMzZ4L0NOW7zTv","amount":"21","amount_captured":"2100","status":"succeeded","payment_method":"visa","created_at":"2021-09-08T10:14:13.000000Z","updated_at":"2021-09-08T10:14:13.000000Z"},{"id":2,"provider_id":"139","user_id":null,"payment_id":"ch_3JXNp9CiKsbMzZ4L0fSECfIw","amount":"21","amount_captured":"2100","status":"succeeded","payment_method":"visa","created_at":"2021-09-08T10:16:12.000000Z","updated_at":"2021-09-08T10:16:12.000000Z"},{"id":3,"provider_id":"139","user_id":null,"payment_id":"ch_3JXNzkCiKsbMzZ4L191B1V4K","amount":"10","amount_captured":"1000","status":"succeeded","payment_method":"visa","created_at":"2021-09-08T10:27:09.000000Z","updated_at":"2021-09-08T10:27:09.000000Z"},{"id":4,"provider_id":"139","user_id":null,"payment_id":"ch_3JXOA6CiKsbMzZ4L0xiPoz0y","amount":"18","amount_captured":"1800","status":"succeeded","payment_method":"visa","created_at":"2021-09-08T10:37:51.000000Z","updated_at":"2021-09-08T10:37:51.000000Z"},{"id":5,"provider_id":"139","user_id":null,"payment_id":"ch_3JXOETCiKsbMzZ4L0PDyebvz","amount":"100","amount_captured":"10000","status":"succeeded","payment_method":"visa","created_at":"2021-09-08T10:42:21.000000Z","updated_at":"2021-09-08T10:42:21.000000Z"},{"id":6,"provider_id":"139","user_id":null,"payment_id":"ch_3JXOVGCiKsbMzZ4L1Qyb0UiV","amount":"5","amount_captured":"500","status":"succeeded","payment_method":"visa","created_at":"2021-09-08T10:59:42.000000Z","updated_at":"2021-09-08T10:59:42.000000Z"},{"id":7,"provider_id":"139","user_id":null,"payment_id":"ch_3JXOXdCiKsbMzZ4L1ECVPGWI","amount":"1","amount_captured":"100","status":"succeeded","payment_method":"visa","created_at":"2021-09-08T11:02:10.000000Z","updated_at":"2021-09-08T11:02:10.000000Z"},{"id":8,"provider_id":"139","user_id":null,"payment_id":"ch_3JXOaGCiKsbMzZ4L0wo3UX9m","amount":"1","amount_captured":"100","status":"succeeded","payment_method":"visa","created_at":"2021-09-08T11:04:53.000000Z","updated_at":"2021-09-08T11:04:53.000000Z"},{"id":9,"provider_id":"139","user_id":null,"payment_id":"ch_3JXObzCiKsbMzZ4L0vWZggEm","amount":"1","amount_captured":"100","status":"succeeded","payment_method":"visa","created_at":"2021-09-08T11:06:40.000000Z","updated_at":"2021-09-08T11:06:40.000000Z"},{"id":10,"provider_id":"139","user_id":null,"payment_id":"ch_3JXOdTCiKsbMzZ4L1WqVoVNL","amount":"1","amount_captured":"100","status":"succeeded","payment_method":"visa","created_at":"2021-09-08T11:08:12.000000Z","updated_at":"2021-09-08T11:08:12.000000Z"}],"first_page_url":"https://api.farenow.com/api/provider/transaction/history?page=1","from":1,"last_page":2,"last_page_url":"https://api.farenow.com/api/provider/transaction/history?page=2","next_page_url":"https://api.farenow.com/api/provider/transaction/history?page=2","path":"https://api.farenow.com/api/provider/transaction/history","per_page":10,"prev_page_url":null,"to":10,"total":13}
/// message : "OK"

class TransationResponse {
  bool? error;
  var transationData;
  var message;

  TransationResponse({this.error, this.transationData, this.message});

  TransationResponse.fromJson(dynamic json) {
    error = json["error"];
    transationData =
        json["data"] != null ? TransationData.fromJson(json["data"]) : null;
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (transationData != null) {
      map["data"] = transationData.toJson();
    }
    map["message"] = message;
    return map;
  }
}
