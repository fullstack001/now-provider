import 'all_notifications_data_model.dart';

class AllNotificationsData {
  AllNotificationsData({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.allNotificationsModelData,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  AllNotificationsData.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    allNotificationsModelData = json['data'] != null
        ? AllNotificationDataModel.fromJson(json['data'])
        : null;
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  var id;
  var type;
  var notifiableType;
  var notifiableId;
  var allNotificationsModelData;
  dynamic readAt;
  var createdAt;
  var updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['notifiable_type'] = notifiableType;
    map['notifiable_id'] = notifiableId;
    if (allNotificationsModelData != null) {
      map['data'] = allNotificationsModelData.toJson();
    }
    map['read_at'] = readAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
