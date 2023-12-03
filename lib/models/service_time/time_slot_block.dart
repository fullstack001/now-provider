// To parse this JSON data, do
//
//     final blockSlots = blockSlotsFromJson(jsonString);

import 'dart:convert';

BlockSlots blockSlotsFromJson(String str) =>
    BlockSlots.fromJson(json.decode(str));

String blockSlotsToJson(BlockSlots data) => json.encode(data.toJson());

class BlockSlots {
  BlockSlots({
    required this.blockedSlots,
  });

  List<BlockedSlot> blockedSlots;

  factory BlockSlots.fromJson(Map<String, dynamic> json) => BlockSlots(
        blockedSlots: List<BlockedSlot>.from(
            json["blockedSlots"].map((x) => BlockedSlot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "blockedSlots": List<dynamic>.from(blockedSlots.map((x) => x.toJson())),
      };
}

class BlockedSlot {
  BlockedSlot({
    required this.id,
    required this.providerId,
    required this.date,
    required this.fromTime,
    required this.toTime,
  });

  int id;
  int providerId;
  DateTime date;
  String fromTime;
  String toTime;

  factory BlockedSlot.fromJson(Map<String, dynamic> json) => BlockedSlot(
        id: json["id"],
        providerId: json["provider_id"],
        date: DateTime.parse(json["date"]),
        fromTime: json["from_time"],
        toTime: json["to_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "provider_id": providerId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "from_time": fromTime,
        "to_time": toTime,
      };
}
