import 'dart:io';

import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:fare_now_provider/screens/service_timings/controller/choose_time_dilalog_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controller/service_timing_controller.dart';

class ChooseTimeDialog extends StatelessWidget {
  ChooseTimeDialogController chooseTimeDialogController;
  Function okTap;
  String text;
  ChooseTimeDialog(
      {required this.text,
      required this.chooseTimeDialogController,
      required this.okTap});

  DateController dateController = Get.put(DateController());
  @override
  Widget build(BuildContext context) {
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(16)),
              width: Get.width * 0.6,
              // width: Get.width * 0.6,
              height: Get.width * 0.8,
              // height: Get.width * 0.8,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    topText(context, text),
                    // ElevatedButton(onPressed: (){
                    //   DatePicker.showTimePicker(context, showTitleActions: true,
                    //       onChanged: (date) {
                    //         dateController.startTime.value=date.toString().split(' ').last.split('.').first;
                    //       }, onConfirm: (date) {
                    //         dateController.startTime.value=date.toString().split(' ').last.split('.').first;
                    //       }, currentTime: DateTime.now());
                    // }, child: Text("Select Time"))

                    // AnalogClock(

                    // decoration: BoxDecoration(
                    // border: Border.all(width: 2.0, color: Colors.black),
                    // color: Colors.transparent,
                    // shape: BoxShape.circle),
                    // width: 250.0,
                    // height: 250.0,
                    // isLive: true,
                    // hourHandColor: Colors.black,
                    // minuteHandColor: Colors.black,
                    // showSecondHand: false,
                    // numberColor: Colors.black87,
                    // showNumbers: true,
                    // showAllNumbers: false,
                    // textScaleFactor: 1.4,
                    // showTicks: false,
                    // showDigitalClock: false,
                    // datetime: DateTime(2019, 1, 1, 9, 12, 15),
                    // ),
                    amPmSection(),
                    centerText(context),
                    textFieldOfTiming(context),
                    //new
                    rowOfDialogButton(context)
                  ]),
            ),
          ),
        )
      ],
    );
  }

  Row rowOfDialogButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        textButtonForDialog(() {
          Get.back();
        }, "Cancel"),
        textButtonForDialog(okTap, "Ok"),
      ],
    );
  }

  AppButton textButtonForDialog(Function onTap, String text) {
    return AppButton(
      onTap: onTap,
      color: Colors.white,
      elevation: 0,
      child: Text(
        text,
        style: TextStyle(
            color: Colors.blue.shade400,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
    );
  }
  //new
  /*textFieldOfTiming(context) {
    return Material(
      child: Row(
        children: [
          textfieldOfDialog("Hour", chooseTimeDialogController.startHour),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                ":",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          textfieldOfDialog("Minute", chooseTimeDialogController.startMinute),
        ],
      ),
    );
  }*/
  textFieldOfTiming(context) {
    return
        // InkWell(
        // onTap: (){
        //   DatePicker.showTimePicker(context, showTitleActions: true,
        //       onChanged: (date) {
        //         dateController.startTime.value=date.toString().split(' ').last.split('.').first;
        //       }, onConfirm: (date) {
        //         dateController.startTime.value=date.toString().split(' ').last.split('.').first;
        //       }, currentTime: DateTime.now());
        // },
        Material(
      child: Row(
        children: [
          textfieldOfDialog("Hour",
              chooseTimeDialogController.hour ),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  ":",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )),
          textfieldOfDialog(
            "Minute",
            chooseTimeDialogController.minute,
          ),
        ],
      ),
    );
  }

  Flexible textfieldOfDialog(
    String text,
    TextEditingController textcontroller,
  ) {
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: Column(
        children: [
          TextFormField(
              // readOnly: true,
              inputFormatters: [
                LengthLimitingTextInputFormatter(2),
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,4}'))
              ],
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              controller: textcontroller,
              textInputAction: TextInputAction.done,
              keyboardType: Platform.isIOS
                  ? TextInputType.numberWithOptions(signed: true, decimal: true)
                  : TextInputType.number,
              onEditingComplete: () {
                print("complete");
              },
              onFieldSubmitted: (val) {
                okTap();
              },
              decoration: InputDecoration(
                  hintText: "00",
                  hintStyle: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w300,
                      color: Colors.black26),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade300)))),
          5.height,
          Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }

  Align centerText(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Type in Time",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w700, color: Colors.black54),
        ));
  }
  //new
 /* AnimatedButtonBar amPmSection() {
    return AnimatedButtonBar(
      radius: 8.0,
      backgroundColor: Colors.grey.shade200,
      foregroundColor: Colors.blueAccent.shade400,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
      invertedSelection: true,
      children: [
        ButtonBarEntry(
          onTap: () {
            chooseTimeDialogController.timeFormat = "AM";
          },
          child: const Text('AM'),
        ),
        ButtonBarEntry(
          onTap: () {
            chooseTimeDialogController.timeFormat = "PM";
          },
          child: const Text('PM'),
        ),
      ],
    );
  }*/


   AnimatedButtonBar amPmSection() {
    return AnimatedButtonBar(
      radius: 8.0,
      backgroundColor: Colors.grey.shade200,
      foregroundColor: Colors.blueAccent.shade400,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
      invertedSelection: true,
      children: [
        ButtonBarEntry(
            onTap: () {
              chooseTimeDialogController.timeFormat = "AM";
            },
            child: const Text('AM')),
        ButtonBarEntry(
            onTap: () {
              chooseTimeDialogController.timeFormat = "PM";
            },
            child: const Text('PM')),
      ],
    );
  }

  Container topText(BuildContext context, String text) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "${text} Time",
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
