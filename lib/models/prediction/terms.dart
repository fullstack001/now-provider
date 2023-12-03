/// offset : 0
/// value : "54700"

class Terms {
  int? offset;
  String? value;

  Terms({
      this.offset, 
      this.value});

  Terms.fromJson(dynamic json) {
    offset = json["offset"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["offset"] = offset;
    map["value"] = value;
    return map;
  }

}