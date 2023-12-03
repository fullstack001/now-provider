import 'predictions.dart';

/// predictions : [{"description":"54700 L'Île d'Esch, Pont-à-Mousson, France","matched_substrings":[{"length":5,"offset":0}],"place_id":"ChIJXamBoZnHlEcR6-T8LS1VMZE","reference":"ChIJXamBoZnHlEcR6-T8LS1VMZE","structured_formatting":{"main_text":"54700 L'Île d'Esch","main_text_matched_substrings":[{"length":5,"offset":0}],"secondary_text":"Pont-à-Mousson, France"},"terms":[{"offset":0,"value":"54700"},{"offset":6,"value":"L'Île d'Esch"},{"offset":20,"value":"Pont-à-Mousson"},{"offset":36,"value":"France"}],"types":["street_address","geocode"]},{"description":"Doctor Horacio Duran 54700, Centro Urbano, Cuautitlán Izcalli, State of Mexico, Mexico","matched_substrings":[{"length":5,"offset":21}],"place_id":"ChIJJ76jljke0oURqvltjPbJLEA","reference":"ChIJJ76jljke0oURqvltjPbJLEA","structured_formatting":{"main_text":"Doctor Horacio Duran 54700","main_text_matched_substrings":[{"length":5,"offset":21}],"secondary_text":"Centro Urbano, Cuautitlán Izcalli, State of Mexico, Mexico"},"terms":[{"offset":0,"value":"Doctor Horacio Duran"},{"offset":21,"value":"54700"},{"offset":28,"value":"Centro Urbano"},{"offset":43,"value":"Cuautitlán Izcalli"},{"offset":63,"value":"State of Mexico"},{"offset":80,"value":"Mexico"}],"types":["street_address","geocode"]},{"description":"54700 Merrifield Drive, Mishawaka, IN, USA","matched_substrings":[{"length":5,"offset":0}],"place_id":"ChIJZfEXrfvRFogRXLBQJgsQ4Uw","reference":"ChIJZfEXrfvRFogRXLBQJgsQ4Uw","structured_formatting":{"main_text":"54700 Merrifield Drive","main_text_matched_substrings":[{"length":5,"offset":0}],"secondary_text":"Mishawaka, IN, USA"},"terms":[{"offset":0,"value":"54700"},{"offset":6,"value":"Merrifield Drive"},{"offset":24,"value":"Mishawaka"},{"offset":35,"value":"IN"},{"offset":39,"value":"USA"}],"types":["premise","geocode"]},{"description":"54700 Buckeye Road, Mishawaka, IN, USA","matched_substrings":[{"length":5,"offset":0}],"place_id":"ChIJO5rXOgfQFogRSSzi2r7rBB8","reference":"ChIJO5rXOgfQFogRSSzi2r7rBB8","structured_formatting":{"main_text":"54700 Buckeye Road","main_text_matched_substrings":[{"length":5,"offset":0}],"secondary_text":"Mishawaka, IN, USA"},"terms":[{"offset":0,"value":"54700"},{"offset":6,"value":"Buckeye Road"},{"offset":20,"value":"Mishawaka"},{"offset":31,"value":"IN"},{"offset":35,"value":"USA"}],"types":["premise","geocode"]},{"description":"54700 Southwest Scoggins Valley Road, Gaston, OR, USA","matched_substrings":[{"length":5,"offset":0}],"place_id":"ChIJJzZ6owUilVQRglZMPtBgckQ","reference":"ChIJJzZ6owUilVQRglZMPtBgckQ","structured_formatting":{"main_text":"54700 Southwest Scoggins Valley Road","main_text_matched_substrings":[{"length":5,"offset":0}],"secondary_text":"Gaston, OR, USA"},"terms":[{"offset":0,"value":"54700"},{"offset":6,"value":"Southwest Scoggins Valley Road"},{"offset":38,"value":"Gaston"},{"offset":46,"value":"OR"},{"offset":50,"value":"USA"}],"types":["street_address","geocode"]}]
/// status : "OK"

class PredictionResponse {
  var predictions;
  var status;

  PredictionResponse({
      this.predictions, 
      this.status});

  PredictionResponse.fromJson(dynamic json) {
    if (json["predictions"] != null) {
      predictions = [];
      json["predictions"].forEach((v) {
        predictions?.add(Predictions.fromJson(v));
      });
    }
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (predictions != null) {
      map["predictions"] = predictions?.map((v) => v.toJson()).toList();
    }
    map["status"] = status;
    return map;
  }

}