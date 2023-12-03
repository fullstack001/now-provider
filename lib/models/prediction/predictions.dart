import 'matched_substrings.dart';
import 'structured_formatting.dart';
import 'terms.dart';

/// description : "54700 L'Île d'Esch, Pont-à-Mousson, France"
/// matched_substrings : [{"length":5,"offset":0}]
/// place_id : "ChIJXamBoZnHlEcR6-T8LS1VMZE"
/// reference : "ChIJXamBoZnHlEcR6-T8LS1VMZE"
/// structured_formatting : {"main_text":"54700 L'Île d'Esch","main_text_matched_substrings":[{"length":5,"offset":0}],"secondary_text":"Pont-à-Mousson, France"}
/// terms : [{"offset":0,"value":"54700"},{"offset":6,"value":"L'Île d'Esch"},{"offset":20,"value":"Pont-à-Mousson"},{"offset":36,"value":"France"}]
/// types : ["street_address","geocode"]

class Predictions {
  var description;
  var matchedSubstrings;
  var placeId;
  var reference;
  var structuredFormatting;
  var terms;
  var types;

  Predictions({
      this.description, 
      this.matchedSubstrings, 
      this.placeId, 
      this.reference, 
      this.structuredFormatting, 
      this.terms, 
      this.types});

  Predictions.fromJson(dynamic json) {
    description = json["description"];
    if (json["matched_substrings"] != null) {
      matchedSubstrings = [];
      json["matched_substrings"].forEach((v) {
        matchedSubstrings?.add(Matched_substrings.fromJson(v));
      });
    }
    placeId = json["place_id"];
    reference = json["reference"];
    structuredFormatting = json["structured_formatting"] != null ? Structured_formatting.fromJson(json["structured_formatting"]) : null;
    if (json["terms"] != null) {
      terms = [];
      json["terms"].forEach((v) {
        terms?.add(Terms.fromJson(v));
      });
    }
    types = json["types"] != null ? json["types"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["description"] = description;
    if (matchedSubstrings != null) {
      map["matched_substrings"] = matchedSubstrings?.map((v) => v.toJson()).toList();
    }
    map["place_id"] = placeId;
    map["reference"] = reference;
    if (structuredFormatting != null) {
      map["structured_formatting"] = structuredFormatting?.toJson();
    }
    if (terms != null) {
      map["terms"] = terms?.map((v) => v.toJson()).toList();
    }
    map["types"] = types;
    return map;
  }

}