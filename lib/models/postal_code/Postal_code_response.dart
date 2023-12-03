import 'Results.dart';


class PostalCodeResponse {
  PostalCodeResponse({
    this.results,
    this.status,
  });

  PostalCodeResponse.fromJson(dynamic json) {
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
    status = json['status'];
  }

  var results;
  var status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (results != null) {
      map['results'] = results.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }
}
