import 'package:fare_now_provider/models/notifications/all_notifications_data.dart';

import 'Links.dart';
import 'Meta.dart';


class AllNotificationsResponse {
  AllNotificationsResponse({
    this.error,
    this.allNotificationsData,
    this.message,
    this.links,
    this.meta,
  });

  AllNotificationsResponse.fromJson(dynamic json) {
    error = json['error'];
    if (json['data'] != null) {
      allNotificationsData = [];
      json['data'].forEach((v) {
        allNotificationsData.add(AllNotificationsData.fromJson(v));
      });
    }
    message = json['message'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  var error;
  var allNotificationsData;
  var message;
  var links;
  var meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    if (allNotificationsData != null) {
      map['data'] = allNotificationsData.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    if (links != null) {
      map['links'] = links.toJson();
    }
    if (meta != null) {
      map['meta'] = meta.toJson();
    }
    return map;
  }
}
