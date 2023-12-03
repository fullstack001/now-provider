import 'user_chat_data.dart';

/// error : false
/// user_chat_data : {"current_page":1,"user_chat_list_data":[{"id":4,"sender_id":140,"receiver_id":139,"message":"message test","created_at":"2021-09-09T03:45:41.000000Z","updated_at":"2021-09-09T03:45:41.000000Z"},{"id":5,"sender_id":140,"receiver_id":139,"message":"message test","created_at":"2021-09-09T03:57:51.000000Z","updated_at":"2021-09-09T03:57:51.000000Z"},{"id":39,"sender_id":140,"receiver_id":139,"message":"hello","created_at":"2021-09-09T08:13:56.000000Z","updated_at":"2021-09-09T08:13:56.000000Z"},{"id":40,"sender_id":140,"receiver_id":139,"message":"hi my name is nouman","created_at":"2021-09-09T08:17:33.000000Z","updated_at":"2021-09-09T08:17:33.000000Z"},{"id":42,"sender_id":139,"receiver_id":140,"message":"hihi","created_at":"2021-09-09T10:55:30.000000Z","updated_at":"2021-09-09T10:55:30.000000Z"},{"id":47,"sender_id":139,"receiver_id":140,"message":"this is new message","created_at":"2021-09-09T11:22:18.000000Z","updated_at":"2021-09-09T11:22:18.000000Z"},{"id":48,"sender_id":139,"receiver_id":140,"message":"ABC ABC ABC","created_at":"2021-09-09T11:22:49.000000Z","updated_at":"2021-09-09T11:22:49.000000Z"},{"id":49,"sender_id":139,"receiver_id":140,"message":"new message","created_at":"2021-09-09T11:25:21.000000Z","updated_at":"2021-09-09T11:25:21.000000Z"},{"id":50,"sender_id":139,"receiver_id":140,"message":"hello my friend","created_at":"2021-09-09T11:26:15.000000Z","updated_at":"2021-09-09T11:26:15.000000Z"},{"id":52,"sender_id":139,"receiver_id":140,"message":"hello","created_at":"2021-09-09T11:54:32.000000Z","updated_at":"2021-09-09T11:54:32.000000Z"}],"first_page_url":"https://api.farenow.com/api/provider/message/chat/140?page=1","from":1,"last_page":1,"last_page_url":"https://api.farenow.com/api/provider/message/chat/140?page=1","next_page_url":null,"path":"https://api.farenow.com/api/provider/message/chat/140","per_page":20,"prev_page_url":null,"to":10,"total":10}
/// message : "OK"

class UserChatResponse {
  var error;
  var userChatData;
  var message;

  UserChatResponse({
      this.error, 
      this.userChatData, 
      this.message});

  UserChatResponse.fromJson(dynamic json) {
    error = json["error"];
    userChatData = json["data"] != null ? UserChatData.fromJson(json["data"]) : null;
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (userChatData != null) {
      map["data"] = userChatData.toJson();
    }
    map["message"] = message;
    return map;
  }

}