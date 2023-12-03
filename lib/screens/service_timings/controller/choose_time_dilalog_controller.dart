import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseTimeDialogController extends GetxController {
  TextEditingController hour = TextEditingController(text: '8');
  TextEditingController minute = TextEditingController(text: '00');
  TextEditingController endHour = TextEditingController(text: '4');
  TextEditingController endMinute = TextEditingController(text: '00');
  String timeFormat = "AM";
  String endTimeFormat = "PM";
  //new
  /*TextEditingController startHour = TextEditingController(text: '8');
  TextEditingController startMinute = TextEditingController(text: '00');
  TextEditingController endHour = TextEditingController(text: '4');
  TextEditingController endMinute = TextEditingController(text: '00');

  setSeelctedValue(BuildContext context) {
    if (startHour.text.isNumericOnly || endHour.text.isNumericOnly&&

        startMinute.text.isNumericOnly|| endMinute.text.isNumericOnly &&
       startHour.text.isNotEmpty|| endHour.text.isNotEmpty &&
       startMinute.text.isNotEmpty ||endMinute.text.isNotEmpty&&
        int.parse(startHour.text) > 0 &&
        int.parse(endHour.text) > 0 &&
        int.parse(startHour.text) < 13 &&
        int.parse(endHour.text) < 13 &&
        int.parse(startMinute.text) >= 0 &&
        int.parse(startMinute.text) >= 0 &&
        int.parse(startMinute.text) < 60&&
        int.parse(minute.text) < 60) {
      return getOrignalTime(hour.text, minute.text, timeFormat, context);
    } else {
      hour.text = "";
      minute.text = "";
      this.timeFormat = "AM";
      Get.back();
      Get.rawSnackbar(message: "Choose Correct Time");
    }
    update();
  }*/
  setSeelctedValue(BuildContext context) {
    if (hour.text.isNumericOnly &&
        minute.text.isNumericOnly &&
        hour.text.isNotEmpty &&
        minute.text.isNotEmpty &&
        int.parse(hour.text) > 0 &&
        int.parse(hour.text) < 13 &&
        int.parse(minute.text) >= 0 &&
        int.parse(minute.text) < 60) {
      return getOrignalTime(hour.text, minute.text, timeFormat, context);
    } else {
      hour.text = "";
      minute.text = "";
      this.timeFormat = "AM";
      Get.back();
      Get.rawSnackbar(message: "Choose Correct Time");
    }
    update();
  }
  setEndSeelctedValue(BuildContext context) {
    if (endHour.text.isNumericOnly &&
        endMinute.text.isNumericOnly &&
        endHour.text.isNotEmpty &&
        endMinute.text.isNotEmpty &&
        int.parse(endHour.text) > 0 &&
        int.parse(endHour.text) < 13 &&
        int.parse(endMinute.text) >= 0 &&
        int.parse(endMinute.text) < 60) {
      return getOrignalTime(endHour.text, endMinute.text, endTimeFormat, context);
    } else {
      endHour.text = "";
      endMinute.text = "";
      this.endTimeFormat = "PM";
      Get.back();
      Get.rawSnackbar(message: "Choose Correct Time");
    }
    update();
  }

  getOrignalTime(
      String text, String text2, String timeFormat, BuildContext context) {
    int selectedHour;
    if (timeFormat == "AM" && int.parse(text) < 12) {
      selectedHour = int.parse(text);
    } else if (timeFormat == "PM" && int.parse(text) < 12) {
      selectedHour = int.parse(text) + 12;
    } else if (timeFormat == "AM" && int.parse(text) == 12) {
      selectedHour = 00;
    } else {
      selectedHour = 12;
    }
    // var time =
    //     TimeOfDay(hour: selectedHour, minute: int.parse(text2)).format(context);
    hour.text = "";
    minute.text = "";
    this.timeFormat = "AM";
    var secondTime = "${selectedHour}:${text2}";
    return secondTime;
  }
  getEndOrignalTime(
      String text, String text2, String timeFormat, BuildContext context) {
    int selectedHour;
    if (timeFormat == "AM" && int.parse(text) < 12) {
      selectedHour = int.parse(text);
    } else if (timeFormat == "PM" && int.parse(text) < 12) {
      selectedHour = int.parse(text) + 12;
    } else if (timeFormat == "AM" && int.parse(text) == 12) {
      selectedHour = 00;
    } else {
      selectedHour = 12;
    }
    // var time =
    //     TimeOfDay(hour: selectedHour, minute: int.parse(text2)).format(context);
    endHour.text = "";
  endMinute.text = "";
    this.endTimeFormat = "PM";
    var secondEndTime = "${selectedHour}:${text2}";
    return secondEndTime;
  }
  //new
  /*getOrignalTime(
      String hourText, String minuteText, String timeFormat, BuildContext context) {
    int selectedHour;
    if (timeFormat == "AM" && int.parse(hourText) < 12) {
      selectedHour = int.parse(hourText);
    } else if (timeFormat == "PM" && int.parse(hourText) < 12) {
      selectedHour = int.parse(hourText) + 12;
    } else if (timeFormat == "AM" && int.parse(hourText) == 12) {
      selectedHour = 0;
    } else {
      selectedHour = 12;
    }
    var formattedTime = "${selectedHour}:${minuteText}";
    return formattedTime;
  }*/
}
