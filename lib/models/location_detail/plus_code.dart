/// compound_code : "4HVX+74 North Hollywood, Los Angeles, CA, USA"
/// global_code : "85634HVX+74"

class PlusCode {
  var compoundCode;
  var globalCode;

  PlusCode({
      this.compoundCode, 
      this.globalCode});

  PlusCode.fromJson(dynamic json) {
    compoundCode = json["compound_code"];
    globalCode = json["global_code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["compound_code"] = compoundCode;
    map["global_code"] = globalCode;
    return map;
  }

}