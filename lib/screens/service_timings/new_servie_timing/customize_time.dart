import 'package:fare_now_provider/screens/service_timings/controller/service_timing_controller.dart';
import 'package:fare_now_provider/screens/service_timings/new_servie_timing/part_of_service_timing/app_bar_of_service_timing.dart';
import 'package:fare_now_provider/screens/service_timings/new_servie_timing/serive_timing_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controller/choose_time_dilalog_controller.dart';
import '../dialog_box/choose_time.dart';

class CustomizeServiceTiming extends StatelessWidget {
  final _grey = const Color(0xffE0E0E0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceTimingController>(
      init: ServiceTimingController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: appBarOfServiceTiming(
              context, "Cutomize Availability", "Done", () async {
            await controller.storeDetail(true);
          }),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(children: [
                30.height,
                topCard(context, controller),
                20.height,
                Card(
                  color: white,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black45, width: 1),
                      borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      availableTitle(),
                      10.height,
                      daysGroupButton(),
                      10.height,
                      const Divider(
                        thickness: 1,
                        color: Colors.black54,
                      ),
                      radioButtonOfDays(controller),
                      const Divider(
                        thickness: 1,
                        color: Colors.black54,
                      ),
                      10.height,
                      controller.selectedRadioButton
                              .contains("Use same time for all days selected")
                          ? Container(
                              child: Column(children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Time",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                sameDayTime(context, controller),
                              ]),
                            )
                          : Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Day \& Time",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        const Text(
                                          "All-day",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        10.width,
                                        FittedBox(
                                          child: CupertinoSwitch(
                                              activeColor: controller.blue,
                                              value: controller.switchSelected,
                                              onChanged: (value) {
                                                controller
                                                    .updateSwitchStatus(value);
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              !controller.switchSelected
                                  ? Column(
                                      children: List.generate(
                                          controller.customTimeList.length,
                                          (index) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    AppButton(
                                                      color: _grey,
                                                      elevation: 2,
                                                      width: 110,
                                                      height: 47,
                                                      shapeBorder:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14)),
                                                      onTap: () {},
                                                      child: FittedBox(
                                                        child: Text(
                                                          controller
                                                              .customTimeList[
                                                                  index]
                                                              .day!,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black87,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ),
                                                    ),
                                                    12.width,
                                                    GetBuilder<
                                                            ChooseTimeDialogController>(
                                                        init:
                                                            ChooseTimeDialogController(),
                                                        builder:
                                                            (chooseController) {
                                                          return Flexible(
                                                            fit: FlexFit.tight,
                                                            flex: 4,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4),
                                                              child: Container(
                                                                height: 50,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8),
                                                                decoration: BoxDecoration(
                                                                    color: const Color(
                                                                        0xffE0E0E0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            14)),
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Flexible(
                                                                        flex: 3,
                                                                        fit: FlexFit
                                                                            .tight,
                                                                        child: GestureDetector(
                                                                            onTap: () {
                                                                              Get.dialog(ChooseTimeDialog(
                                                                                  text: "Start",
                                                                                  chooseTimeDialogController: chooseController,
                                                                                  okTap: () {
                                                                                    var value = chooseController.setSeelctedValue(context);

                                                                                    if (value != null) {
                                                                                      controller.setStartSelectedTime(index, value);
                                                                                      Get.back();
                                                                                    }
                                                                                  }));
                                                                            },
                                                                            child: FittedBox(
                                                                                child: Text(
                                                                              converTimeFrom24Hour(controller.customTimeList[index].from_time!, context),
                                                                              style: const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w400),
                                                                            ))),
                                                                      ),
                                                                      const Flexible(
                                                                        flex: 1,
                                                                        fit: FlexFit
                                                                            .loose,
                                                                        child: FittedBox(
                                                                            child: Text(
                                                                          "-",
                                                                          style: TextStyle(
                                                                              fontSize: 23,
                                                                              fontWeight: FontWeight.w100),
                                                                        )),
                                                                      ),
                                                                      Flexible(
                                                                        flex: 3,
                                                                        fit: FlexFit
                                                                            .tight,
                                                                        child: GestureDetector(
                                                                            onTap: () {
                                                                              Get.dialog(ChooseTimeDialog(
                                                                                  text: "End",
                                                                                  chooseTimeDialogController: chooseController,
                                                                                  okTap: () {
                                                                                    var value = chooseController.setSeelctedValue(context);

                                                                                    if (value != null) {
                                                                                      controller.setEndSelectedTime(index, value);
                                                                                      Get.back();
                                                                                    }
                                                                                  }));
                                                                            },
                                                                            child: FittedBox(child: Text(converTimeFrom24Hour(controller.customTimeList[index].to_time!, context), style: const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w300)))),
                                                                      )
                                                                    ]),
                                                              ),
                                                            ),
                                                          );
                                                        })
                                                  ],
                                                ),
                                              )),
                                    )
                                  : Container()
                            ])
                    ]),
                  ),
                )
              ]),
            ),
          ),
        );
      },
    );
  }

  // getAvailableTimeSlot(
  //     ServiceTimingController controller, BuildContext context) {
  //   return RichText(
  //     text: TextSpan(
  //         text: "Preferred availability set to ",
  //         style: const TextStyle(color: black, fontSize: 16),
  //         children: [
  //           TextSpan(
  //             children: List.generate(
  //                 controller.scheduleElement.length,
  //                 (index) => TextSpan(children: [
  //                       TextSpan(
  //                           text:
  //                               "${controller.scheduleElement[index].day.substring(0, 3)}",
  //                           style: const TextStyle(
  //                               color: Color(0xff00B181), fontSize: 16)),
  //                       const TextSpan(
  //                           text: ", ",
  //                           style: TextStyle(color: black, fontSize: 16))
  //                     ])),
  //           ),
  //           const TextSpan(
  //               text: " at ",
  //               style: TextStyle(
  //                   color: black, fontSize: 16, fontWeight: FontWeight.w400)),
  //           TextSpan(children: [
  //             TextSpan(
  //                 text:
  //                     "${converTimeFrom24Hour(controller.scheduleElement[0].fromTime, context)}",
  //                 style:
  //                     const TextStyle(color: Color(0xff00B181), fontSize: 16)),
  //             const TextSpan(
  //                 text: " to ", style: TextStyle(color: black, fontSize: 16)),
  //             TextSpan(
  //                 text:
  //                     "${converTimeFrom24Hour(controller.scheduleElement[0].toTime, context)}",
  //                 style:
  //                     const TextStyle(color: Color(0xff00B181), fontSize: 16)),
  //           ]),
  //         ]),
  //   );
  // }

  RadioGroup<String> radioButtonOfDays(ServiceTimingController controller) {
    return RadioGroup<String>.builder(
      activeColor: controller.blue,
      textStyle: const TextStyle(fontSize: 16, color: black),
      groupValue: controller.selectedRadioButton,
      onChanged: (value) {
        controller.updateSelectedRadioButton(value!);
      },
      items: const [
        "Use same time for all days selected",
        "Set time individually for selected days"
      ],
      itemBuilder: (item) => RadioButtonBuilder(
        item,
      ),
      horizontalAlignment: MainAxisAlignment.start,
    );
  }

  daysGroupButton() {
    return GetBuilder<ServiceTimingController>(
        init: ServiceTimingController(),
        builder: (controller) {
          return FittedBox(
            child: GroupButton(
              controller: controller.controller,
              isRadio: false,
              enableDeselect: false,
              onSelected: (String value, index, status) {
                controller.addSelectedDay(value);
              },
              options: GroupButtonOptions(
                selectedShadow: const [],
                selectedTextStyle: const TextStyle(
                  fontSize: 16,
                  color: white,
                ),
                selectedColor: controller.blue,
                unselectedShadow: const [],
                unselectedColor: white,
                unselectedTextStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500),
                selectedBorderColor: controller.blue,
                unselectedBorderColor: Colors.black45,
                borderRadius: BorderRadius.circular(100),
                spacing: 10,
                runSpacing: 10,
                groupingType: GroupingType.wrap,
                direction: Axis.horizontal,
                buttonHeight: 40,
                buttonWidth: 40,
                mainGroupAlignment: MainGroupAlignment.start,
                crossGroupAlignment: CrossGroupAlignment.start,
                groupRunAlignment: GroupRunAlignment.start,
                textAlign: TextAlign.center,
                textPadding: EdgeInsets.zero,
                alignment: Alignment.center,
                elevation: 0,
              ),
              buttonBuilder: (selected, String value, context) {
                return FittedBox(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: chekValue(value, controller)
                              ? controller.blue
                              : Colors.black45),
                      color: chekValue(value, controller)
                          ? controller.blue
                          : Colors.white,
                    ),
                    child: FittedBox(
                        child: Text(
                      "${value}".substring(0, 2),
                      style: TextStyle(
                          color: chekValue(value, controller)
                              ? Colors.white
                              : Colors.black),
                    )),
                  ),
                );
              },
              buttons: controller.listOfDays,
            ),
          );
        });
  }

  Container availableTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: const Text(
        "Available on:",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  sameDayTime(BuildContext context, ServiceTimingController controller) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GetBuilder<ChooseTimeDialogController>(
                  init: ChooseTimeDialogController(),
                  builder: (choosecontroller) {
                    return AppButton(
                      color: const Color(0xffE0E0E0),
                      elevation: 2,
                      width: 140,
                      height: 47,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      onTap: () {
                        Get.dialog(ChooseTimeDialog(
                            text: "Start",
                            okTap: () {
                              var value =
                                  choosecontroller.setSeelctedValue(context);
                              if (value != null) {
                                controller.changeStartTimeForSameDays(value);
                                Get.back();
                              }
                            },
                            chooseTimeDialogController: choosecontroller));
                      },
                      child: Text(
                        controller.selectedStartTime.contains("Select Time")
                            ? "Select Time"
                            : "${converTimeFrom24Hour(controller.selectedStartTime, context)}",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: controller.selectedStartTime
                                    .contains("Select Time")
                                ? Colors.black54
                                : Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  }),
              Text(
                "  TO  ",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black45, fontWeight: FontWeight.w400),
              ),
              GetBuilder<ChooseTimeDialogController>(
                  init: ChooseTimeDialogController(),
                  builder: (choosecontroller) {
                    return AppButton(
                      color: const Color(0xffE0E0E0),
                      elevation: 2,
                      width: 140,
                      height: 47,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      onTap: () {
                        Get.dialog(ChooseTimeDialog(
                            text: "End",
                            okTap: () {
                              var value =
                                  choosecontroller.setSeelctedValue(context);
                              if (value != null) {
                                controller.changeEndTimeForSameDays(value);
                                Get.back();
                              }
                            },
                            chooseTimeDialogController: choosecontroller));
                      },
                      child: Text(
                        controller.selectedEndTime.contains("Select Time")
                            ? "${controller.selectedEndTime}"
                            : "${converTimeFrom24Hour(controller.selectedEndTime, context)}",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: controller.selectedStartTime
                                    .contains("Select Time")
                                ? Colors.black54
                                : Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  }),
            ],
          ),
        ));
  }

  topCard(BuildContext context, ServiceTimingController controller) {
    return getAvailableTimeSlot(controller, context);
    // return Card(
    //     color: white,
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    //     child: Container(
    //       padding: EdgeInsets.only(right: 12),
    //       child: Row(
    //         children: [
    //           // Flexible(
    //           //   flex: 1,
    //           //   child: Padding(
    //           //     padding: const EdgeInsets.all(10.0),
    //           //     child: Stack(
    //           //       alignment: Alignment.center,
    //           //       children: [
    //           //         Container(
    //           //           width: 50,
    //           //           height: 50,
    //           //           decoration: BoxDecoration(
    //           //               color: const Color(0xffE8F7F1),
    //           //               borderRadius: BorderRadius.circular(13)),
    //           //         ),
    //           //         Padding(
    //           //           padding: const EdgeInsets.all(12.0),
    //           //           child: Container(
    //           //             alignment: Alignment.center,
    //           //             decoration: const BoxDecoration(
    //           //                 color: Colors.green, shape: BoxShape.circle),
    //           //             child: const FittedBox(
    //           //               child: Icon(
    //           //                 Icons.check,
    //           //                 color: white,
    //           //               ),
    //           //             ),
    //           //           ),
    //           //         ),
    //           //       ],
    //           //     ),
    //           //   ),
    //           // ),
    //           Flexible(
    //               flex: 3, child: getAvailableTimeSlot(controller, context))
    //         ],
    //       ),
    //     ));
  }

  chekValue(String? value, ServiceTimingController controller) {
    for (var i = 0; i < controller.customTimeList.length; i++) {
      if (value!.toLowerCase() ==
          controller.customTimeList[i].day!.toLowerCase()) {
        return true;
      }
    }
    return false;
  }
}
