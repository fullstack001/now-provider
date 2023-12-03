import 'documet_data.dart';

/// error : false
/// message : "success"
/// documet_data : {"current_page":1,"documet_list_data":[{"id":8,"user_id":139,"type":"2","name":"612dd9375df68-1630394679.pdf","url":"/storage/provider/docs/files/612dd9375df68-1630394679.pdf","verified":0,"created_at":"2021-08-31T07:24:39.000000Z","updated_at":"2021-08-31T07:24:39.000000Z","quotation_info_id":null}],"first_page_url":"https://api.farenow.com/api/provider/media/listpage=1","from":1,"last_page":1,"last_page_url":"https://api.farenow.com/api/provider/media/listpage=1","next_page_url":null,"path":"https://api.farenow.com/api/provider/media/list","per_page":100,"prev_page_url":null,"to":1,"total":1}

class DocumentResponse {
  var error;
  var message;
  DocumetData? documetData; // Make the field nullable

  DocumentResponse({
    this.error,
    this.message,
    this.documetData,
  });

  DocumentResponse.fromJson(dynamic json) {
    error = json["error"];
    message = json["message"];
    documetData = json["documet_data"] != null ? DocumetData.fromJson(json["documet_data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    map["message"] = message;
    if (documetData != null) {
      map["documet_data"] = documetData!.toJson();
    }
    return map;
  }
}