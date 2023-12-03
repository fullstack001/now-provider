import 'dart:convert';

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));

String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  Schedule({
    required this.schedule,
  });

  List<ScheduleElement> schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        schedule: List<ScheduleElement>.from(
            json["schedule"].map((x) => ScheduleElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
      };
}

class ScheduleElement {
  ScheduleElement({
    required this.id,
    required this.providerId,
    required this.day,
    required this.fromTime,
    required this.toTime,
    required this.isCustom,
  });

  int id;
  int providerId;
  String day;
  String fromTime;
  String toTime;
  int isCustom;

  factory ScheduleElement.fromJson(Map<String, dynamic> json) =>
      ScheduleElement(
        id: json["id"],
        providerId: json["provider_id"],
        day: json["day"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        isCustom: json["is_custom"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "provider_id": providerId,
        "day": day,
        "from_time": fromTime,
        "to_time": toTime,
        "is_custom": isCustom,
      };
}
