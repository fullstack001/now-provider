import 'dart:convert';

import 'package:fare_now_provider/api_service/service_repository.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/models/service_time/time_schedule.dart';
import 'package:fare_now_provider/models/service_time/time_slot_block.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/mybusinessbusinessinformation/v1.dart';
import 'package:group_button/group_button.dart';

import '../../../util/api_utils.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../util/app_dialog_utils.dart';
import '../../../util/shared_reference.dart';

class ServiceTimingController extends GetxController {
  Color blue = Color(0xff0068E1);
  TextEditingController hour = TextEditingController();
  var controller = GroupButtonController();
  List<CustomTime> customTimeList = <CustomTime>[];
  TextEditingController minute = TextEditingController();
  String timeFormat = "AM";
  bool disableflag = false;
  List<String> selectedDays = <String>[];
  List<String> listOfDays = <String>[
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  List<String> listOfTime = <String>[
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
  ];
  String? selectedStartDate;
  String? selectedEndDate;
  String selectedStartTime = "Select Time";
  String selectedEndTime = "Select Time";
  int startIndex = 0;
  int endIndex = 0;
  List<BlockedSlot> blockedSlot = <BlockedSlot>[];
  List<ScheduleElement> scheduleElement = <ScheduleElement>[];
  List<Map<String, dynamic>> selectedList = <Map<String, dynamic>>[];
  @override
  void onInit() {
    getScheduleTiming();
    super.onInit();
  }

  getScheduleTiming() async {
    scheduleElement.clear();
    blockedSlot.clear();
    customTimeList.clear();
    AppDialogUtils.dialogLoading();
    try {
      String? authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);

      var response =
          await ServiceReposiotry().getScheduleTiming(authToken: authToken);

      if (!response['error']) {
        AppDialogUtils.dismiss();
        scheduleElement = Schedule.fromJson(response["data"]).schedule;

        blockedSlot = BlockSlots.fromJson(response['data']).blockedSlots;
        for (var i = 0; i < scheduleElement.length; i++) {
          customTimeList.add(CustomTime(
              day: scheduleElement[i].day,
              from_time: scheduleElement[i].fromTime,
              to_time: scheduleElement[i].toTime));
        }
        update();
      } else {
        AppDialogUtils.dismiss();
      }
    } catch (e) {
      AppDialogUtils.dismiss();
      print("error");
    }
  }

  List<String> items = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  setSelectedDay(String flag, String value) {
    if (flag == "start") {
      startIndex = items.indexWhere((element) => element.contains(value));

      selectedStartDate = value;
    } else if (flag == "end") {
      endIndex = items.indexWhere((element) => element.contains(value));

      selectedEndDate = value;
    }
    update();
  }

  setStartTime(String value, {controller}) {
    if (selectedStartDate != null && selectedEndDate != null) {
      var _hour = value.splitBefore(":");
      var _minute = value.splitAfter(":");
      var _time;
      if (_hour.length < 2) {
        _time = "0${_hour}";
      } else {
        _time = _hour;
      }
      if (_minute.length < 2) {
        _time = "${_time}:0${_minute}";
      } else {
        _time = "${_time}:${_minute}";
      }
      selectedStartTime = _time;
      if (selectedEndTime != "Select Time" &&
          selectedEndTime != "Select Time") {
        int s1 = int.parse(selectedStartTime.splitBefore(":"));
        int e2 = int.parse(selectedEndTime.splitBefore(":"));
        if (campareTwoHours(s1, e2)) {
          int sDay = listOfDays.indexWhere(
            (element) {
              return element == selectedStartDate;
            },
          );
          int eDay = listOfDays.indexWhere(
            (element) {
              return element == selectedEndDate;
            },
          );

          if (sDay < eDay) {
            storeDetail(false);
          } else {
            AppDialogUtils.errorDialog("Select day in sequence");
          }
        } else {
          AppDialogUtils.errorDialog(
              "You can't choose time from a different day");
        }
      }
    } else {
      AppDialogUtils.errorDialog("Please Select Day");
    }

    update();
  }

  setEndTime(String value, {controller}) {
    if (selectedStartDate != null && selectedEndDate != null) {
      var _hour = value.splitBefore(":");
      var _minute = value.splitAfter(":");
      var _time;
      if (_hour.length < 2) {
        _time = "0${_hour}";
      } else {
        _time = _hour;
      }
      if (_minute.length < 2) {
        _time = "${_time}:0${_minute}";
      } else {
        _time = "${_time}:${_minute}";
      }
      selectedEndTime = _time;

      if (selectedEndTime != "Select Time" &&
          selectedEndTime != "Select Time") {
        int s1 = int.parse(selectedStartTime.splitBefore(":"));
        int e2 = int.parse(selectedEndTime.splitBefore(":"));
        if (campareTwoHours(s1, e2)) {
          int sDay = listOfDays.indexWhere(
            (element) {
              return element == selectedStartDate;
            },
          );
          int eDay = listOfDays.indexWhere(
            (element) {
              return element == selectedEndDate;
            },
          );

          if (sDay < eDay) {
            storeDetail(false);
          } else {
            AppDialogUtils.errorDialog("Select day in sequence");
          }
        } else {
          AppDialogUtils.errorDialog(
              "You can't choose time from a different day");
        }
      }
    } else {
      AppDialogUtils.errorDialog("Please Select Day");
    }
    update();
  }

  campareTwoHours(int s1, int e2) {
    if (e2 > s1) {
      return true;
    }
    return false;
  }

  setValueToSelectedList(flag) {
    selectedList.clear();
    if (flag) {
      for (var i = 0; i < customTimeList.length; i++) {
        selectedList.add({
          "day": customTimeList[i].day,
          "from_time": "${customTimeList[i].from_time!}",
          "to_time": "${customTimeList[i].to_time!}",
        });
      }
    } else {
      for (var i = startIndex; i <= endIndex; i++) {
        selectedList.add({"day": items[i]});
      }
    }
  }

  storeDetail(flag) async {
    ProfileScreenController controller = Get.find();
    if (!selectedStartTime.contains("Select Time") &&
            !selectedEndTime.contains("Select Time") ||
        selectedRadioButton != "Use same time for all days selected") {
      AppDialogUtils.dialogLoading();

      try {
        var _body;
        if (flag) {
          setValueToSelectedList(flag);
          _body =
              json.encode({"is_custom": flag, "days": selectedList.toList()});
          selectedEndTime = "Select Time";
          selectedStartTime = "Select Time";
        } else {
          setValueToSelectedList(flag);
          _body = json.encode({
            "is_custom": flag,
            "from_time": "$selectedStartTime",
            "to_time": "$selectedEndTime",
            "days": selectedList.toList()
          });
        }
        print(_body);
        String? authToken =
            await SharedRefrence().getString(key: ApiUtills.authToken);

        var response = await ServiceReposiotry()
            .storeScheduleTimes(authToken: authToken, body: _body);
        if (!response['error']) {
          // AppDialogUtils.successDialog("Updated Successfully");
          await getScheduleTiming();
          await controller.getProfile();
          Get.back();
          selectedEndTime = "Select Time";
          selectedStartTime = "Select Time";
        }
      } catch (e) {
        print("error");
      } finally {
        selectedList.clear();
        AppDialogUtils.dismiss();
      }
    }
  }

  String time12to24Format(String time) {
    int h = int.parse(time.split(":").first);
    int m = int.parse(time.split(":").last.split(" ").first);
    String meridium = time.split(":").last.split(" ").last.toLowerCase();
    if (meridium == "pm") {
      if (h != 12) {
        h = h + 12;
      }
    }
    if (meridium == "am") {
      if (h == 12) {
        h = 00;
      }
    }
    String newTime = "${h == 12 ? "00" : h}:${m == 0 ? "00" : m}".toUpperCase();
    print(newTime);

    return newTime;
  }

  addSelectedDay(String value) {
    if (!disableflag) {
      var contain =
          customTimeList.indexWhere((element) => element.day == value);
      if (contain < 0) {
        if (selectedRadioButton == "Use same time for all days selected") {
          customTimeList.add(CustomTime(
              day: value,
              from_time: selectedStartTime != "Select Time"
                  ? selectedStartTime
                  : "00:00",
              to_time: selectedEndTime != "Select Time"
                  ? selectedEndTime
                  : "23:59"));
        } else {
          customTimeList.add(
              CustomTime(day: value, from_time: "00:00", to_time: "23:59"));
        }
      } else {
        customTimeList.removeAt(contain);
      }
    }
    sortCutomizeList();
    update();
  }

  String selectedRadioButton = "Use same time for all days selected";
  updateSelectedRadioButton(String value) {
    selectedRadioButton = value;
    update();
  }

  bool switchSelected = false;
  updateSwitchStatus(bool val) {
    if (val) {
      switchSelected = val;
      customTimeList.clear();
      for (var i = 0; i < items.length; i++) {
        customTimeList.add(CustomTime(
            day: items[i],
            from_time: scheduleElement.first.fromTime,
            to_time: scheduleElement.first.toTime));
      }
      disableflag = true;
    } else {
      switchSelected = val;
      disableflag = false;
    }
    update();
  }

  void changeEndTimeForSameDays(String value) {
    selectedEndTime = convertHourAndMinutesLength(value);

    customTimeList.forEach((element) {
      element.to_time = convertHourAndMinutesLength(value);
    });
    update();
  }

  void changeStartTimeForSameDays(String value) {
    selectedStartTime = convertHourAndMinutesLength(value);

    customTimeList.forEach((element) {
      element.from_time = convertHourAndMinutesLength(value);
    });

    update();
  }

  sortCutomizeList() {
    List<int> _days = <int>[];
    for (var i = 0; i < customTimeList.length; i++) {
      switch (customTimeList[i].day) {
        case "Monday":
          _days.add(1);

          break;
        case "Tuesday":
          _days.add(2);

          break;
        case "Wednesday":
          _days.add(3);

          break;
        case "Thursday":
          _days.add(4);

          break;
        case "Friday":
          _days.add(5);

          break;
        case "Saturday":
          _days.add(6);

          break;
        case "Sunday":
          _days.add(7);

          break;
        default:
          _days.clear();
      }
    }

    _days.sort();

    for (var i = 0; i < _days.length; i++) {
      switch (_days[i]) {
        case 1:
          customTimeList[i].day = "Monday";

          break;
        case 2:
          customTimeList[i].day = "Tuesday";

          break;
        case 3:
          customTimeList[i].day = "Wednesday";
          break;
        case 4:
          customTimeList[i].day = "Thursday";

          break;
        case 5:
          customTimeList[i].day = "Friday";

          break;
        case 6:
          customTimeList[i].day = "Saturday";

          break;
        case 7:
          customTimeList[i].day = "Sunday";

          break;
        default:
          _days.clear();
      }
    }
  }

  void setStartSelectedTime(int index, String value) {
    int st = int.parse(value.splitBefore(":"));
    int et = int.parse(customTimeList[index].to_time!.splitBefore(":"));
    if (et > st) {
      customTimeList[index].from_time = convertHourAndMinutesLength(value);
    } else {
      AppDialogUtils.errorDialog("You can't choose time from a different day ");
    }

    update();
  }

  void setEndSelectedTime(int index, String value) {
    int st = int.parse(customTimeList[index].from_time!.splitBefore(":"));
    int et = int.parse(value.splitBefore(":"));
    if (et > st) {
      customTimeList[index].to_time = convertHourAndMinutesLength(value);
    } else {
      AppDialogUtils.errorDialog("You can't choose time from a different day ");
    }

    update();
  }

  convertHourAndMinutesLength(String value) {
    var _hour = value.splitBefore(":");
    var _minute = value.splitAfter(":");
    var _time;
    if (_hour.length < 2) {
      _time = "0${_hour}";
    } else {
      _time = _hour;
    }
    if (_minute.length < 2) {
      _time = "${_time}:0${_minute}";
    } else {
      _time = "${_time}:${_minute}";
    }
    return _time;
  }
}

class CustomTime {
  String? day;
  String? from_time;
  String? to_time;
  CustomTime({this.day, this.from_time, this.to_time});
}

class DateController extends GetxController {
  var startTime = "Start Time".obs;
  var endTime = "End Time".obs;
}
