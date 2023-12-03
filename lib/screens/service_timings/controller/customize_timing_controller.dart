import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

class CustomizeTimingController extends GetxController {
  Color blue = Color(0xff0068E1);
  TextEditingController hour = TextEditingController();
  var controller = GroupButtonController();

  TextEditingController minute = TextEditingController();
  String timeFormat = "AM";
  bool disableflag = false;
  List<String> selectedDays = <String>[];
  List<String> listOfDays = <String>[
    "Monday",
    "Tuesday",
    "WednesDay",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  List<String> listOfTime = <String>[
    "10:30AM - 06:30PM",
    "10:30AM - 06:30PM",
    "10:30AM - 06:30PM",
    "10:30AM - 06:30PM",
    "10:30AM - 06:30PM",
    "10:30AM - 06:30PM",
    "10:30AM - 06:30PM",
    "10:30AM - 06:30PM",
  ];

  addSelectedDay(String value, bool status) {
    if (!disableflag) {
      if (status) {
        switch (value) {
          case "M":
            selectedDays.add("Monday");
            break;
          case "T":
            selectedDays.add("Tuesday");
            break;
          case "W":
            selectedDays.add("WednesDay");
            break;
          case "Th":
            selectedDays.add("Thursday");
            break;
          case "F":
            selectedDays.add("Friday");
            break;
          case "Sa":
            selectedDays.add("Saturday");
            break;
          case "S":
            selectedDays.add("Sunday");
            break;
          default:
            selectedDays.clear();
        }
      } else {
        switch (value) {
          case "M":
            selectedDays.remove("Monday");
            break;
          case "T":
            selectedDays.remove("Tuesday");
            break;
          case "W":
            selectedDays.remove("WednesDay");
            break;
          case "Th":
            selectedDays.remove("Thursday");
            break;
          case "F":
            selectedDays.remove("Friday");
            break;
          case "Sa":
            selectedDays.remove("Saturday");
            break;
          case "S":
            selectedDays.remove("Sunday");
            break;
          default:
            selectedDays.clear();
        }
      }
    }
    update();
  }

  String selectedRadioButton = "Use same time for all days selected";
  updateSelectedRadioButton(String value) {
    selectedRadioButton = value;
    update();
  }

  bool switchSelected = false;
  updateSwitchStatus(bool val) {
    switchSelected = val;
    update();
  }
}
