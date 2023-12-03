import 'package:fare_now_provider/models/documents/documet_list_data.dart';

/// current_page : 1
/// documet_list_data : [{"id":8,"user_id":139,"type":"2","name":"612dd9375df68-1630394679.pdf","url":"/storage/provider/docs/files/612dd9375df68-1630394679.pdf","verified":0,"created_at":"2021-08-31T07:24:39.000000Z","updated_at":"2021-08-31T07:24:39.000000Z","quotation_info_id":null}]
/// first_page_url : "https://api.farenow.com/api/provider/media/list?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://api.farenow.com/api/provider/media/listpage=1"
/// next_page_url : null
/// path : "https://api.farenow.com/api/provider/media/list"
/// per_page : 100
/// prev_page_url : null
/// to : 1
/// total : 1

class DocumetData {
  var currentPage;
  var documetListData;
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

  DocumetData({
      this.currentPage, 
      this.documetListData, 
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

  DocumetData.fromJson(dynamic json) {
    currentPage = json["current_page"];
    if (json["data"] != null) {
      documetListData = [];
      json["data"].forEach((v) {
        documetListData.add(DocumetListData.fromJson(v));
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
    if (documetListData != null) {
      map["data"] = documetListData.map((v) => v.toJson()).toList();
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