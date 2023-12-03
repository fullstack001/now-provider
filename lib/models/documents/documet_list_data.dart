/// id : 8
/// user_id : 139
/// type : "2"
/// name : "612dd9375df68-1630394679.pdf"
/// url : "/storage/provider/docs/files/612dd9375df68-1630394679.pdf"
/// verified : 0
/// created_at : "2021-08-31T07:24:39.000000Z"
/// updated_at : "2021-08-31T07:24:39.000000Z"
/// quotation_info_id : null

class DocumetListData {
  var id;
  var userId;
  var type;
  var name;
  var url;
  var verified;
  var createdAt;
  var updatedAt;
  dynamic quotationInfoId;

  DocumetListData({
      this.id, 
      this.userId, 
      this.type, 
      this.name, 
      this.url, 
      this.verified, 
      this.createdAt, 
      this.updatedAt, 
      this.quotationInfoId});

  DocumetListData.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    type = json["type"];
    name = json["name"];
    url = json["url"];
    verified = json["verified"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    quotationInfoId = json["quotation_info_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
    map["type"] = type;
    map["name"] = name;
    map["url"] = url;
    map["verified"] = verified;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["quotation_info_id"] = quotationInfoId;
    return map;
  }

}