import 'portfio_data.dart';

class PortfioResponse {
  PortfioResponse({
    this.error,
    this.portfioData,
    this.message,
  });

  PortfioResponse.fromJson(dynamic json) {
    error = json['error'];
    if (json['data'] != null) {
      portfioData = [];
      json['data'].forEach((v) {
        portfioData.add(PortfioData.fromJson(v));
      });
    }
    message = json['message'];
  }

  var error;
  var portfioData;
  var message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    if (portfioData != null) {
      map['portfio_data'] = portfioData.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }
}
