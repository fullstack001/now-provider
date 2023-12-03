/// length : 5
/// offset : 0

class MainTextMatchedSubstrings {
  int? length;
  int? offset;

  MainTextMatchedSubstrings({
      this.length, 
      this.offset});

  MainTextMatchedSubstrings.fromJson(dynamic json) {
    length = json["length"];
    offset = json["offset"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["length"] = length;
    map["offset"] = offset;
    return map;
  }

}