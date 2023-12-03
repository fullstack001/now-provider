import 'main_text_matched_substrings.dart';

/// main_text : "54700 L'Île d'Esch"
/// main_text_matched_substrings : [{"length":5,"offset":0}]
/// secondary_text : "Pont-à-Mousson, France"

class Structured_formatting {
  var mainText;
  var mainTextMatchedSubstrings;
  var secondaryText;

  Structured_formatting({
      this.mainText, 
      this.mainTextMatchedSubstrings, 
      this.secondaryText});

  Structured_formatting.fromJson(dynamic json) {
    mainText = json["main_text"];
    if (json["main_text_matched_substrings"] != null) {
      mainTextMatchedSubstrings = [];
      json["main_text_matched_substrings"].forEach((v) {
        mainTextMatchedSubstrings?.add(MainTextMatchedSubstrings.fromJson(v));
      });
    }
    secondaryText = json["secondary_text"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["main_text"] = mainText;
    if (mainTextMatchedSubstrings != null) {
      map["main_text_matched_substrings"] = mainTextMatchedSubstrings?.map((v) => v.toJson()).toList();
    }
    map["secondary_text"] = secondaryText;
    return map;
  }

}