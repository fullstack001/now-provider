/// id : 34
/// code : "1234"
/// created_at : "2021-08-24T13:03:32.000000Z"
/// updated_at : "2021-08-24T13:03:32.000000Z"

class ProviderZipcodeData {
  var id;
  var code;
  var createdAt;
  var updatedAt;
  var state;
  var city;
  var country;
  var placeId;

  ProviderZipcodeData(
      {this.id,
      this.code,
      this.city,
      this.country,
      this.state,
      this.placeId,
      this.createdAt,
      this.updatedAt});

  ProviderZipcodeData.fromJson(dynamic json) {
    print(json["service_areas"][0]["place_id"]);
    id = json["id"];
    code = json["code"];
    List list = json['states'].toList();
    placeId = json["service_areas"][0]["place_id"] != null
        ? json["service_areas"][0]["place_id"]
        : "";
    // if (list.isNotEmpty) {
    //   city = json['cities'].toList()[0]['name'];
    //   country = json['cities'].toList()[0]['country']['name'];
    // }
    List stateList = json['states'].toList();
    if (list.isNotEmpty) {
      state = json['states'].toList()[0]['name'];
      // city = json['states'].toList()[1]['name'] != null
      //     ? json['states'].toList()[1]['name']
      //     : "";
      country = json['states'].toList()[0]['country']['name'];
    }

    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["code"] = code;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }
}
