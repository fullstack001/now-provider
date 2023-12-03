/// length : 5
/// offset : 0

class Matched_substrings {
  int? length;
  int? offset;

  Matched_substrings({
      this.length, 
      this.offset});

  Matched_substrings.fromJson(dynamic json) {
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