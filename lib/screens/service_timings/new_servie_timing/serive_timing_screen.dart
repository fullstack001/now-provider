import 'package:fare_now_provider/screens/service_timings/controller/choose_time_dilalog_controller.dart';
import 'package:fare_now_provider/screens/service_timings/controller/service_timing_controller.dart';
import 'package:fare_now_provider/screens/service_timings/dialog_box/choose_time.dart';
import 'package:fare_now_provider/screens/service_timings/new_servie_timing/block_timing.dart';
import 'package:fare_now_provider/screens/service_timings/new_servie_timing/customize_time.dart';
import 'package:fare_now_provider/screens/service_timings/new_servie_timing/part_of_service_timing/dropdown_part.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controller/choose_time_new.dart';
import 'part_of_service_timing/app_bar_of_service_timing.dart';

converTimeFrom24Hour(String time, BuildContext context) {
  // var timeofDay = TimeOfDay(
  //         hour: int.parse(time.splitBefore(":")),
  //         minute: int.parse(time.splitAfter(":")))
  //     .format(context);
  // var timeofDay = TimeOfDay(hour: 23, minute: 3).format(context);
  DateTime tempDate = DateFormat("hh:mm").parse(
      "${int.parse(time.splitBefore(":"))}:${int.parse(time.splitAfter(":"))}");
  var dateFormat = DateFormat("h:mm a"); // you can change the format here

  // if (tempDate.is) {
  // return timeofDay;
  return dateFormat.format(tempDate);
  // } else {
  //   return "";
  // }
}

class ServiceTimingScreen extends StatelessWidget {
  static const id = 'service_timing_screen';
  final _grey = const Color(0xffE0E0E0);

  DateController dateController = Get.put(DateController());
  ServiceTimingController serviceTimingController =
  Get.put(ServiceTimingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceTimingController>(
        init: ServiceTimingController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar:
            appBarOfServiceTiming(context, "Services Timings", "Save", () {
              Get.back();
            }),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: ListView(children: [
                topTextWidget(context),
                controller.scheduleElement.isNotEmpty
                    ? getAvailableTimeSlot(controller, context)
                // getTileWidget(
                //     context,
                //     const Color(0xffE8F7F1),
                //     getAvailableTimeSlot(controller, context),
                //     const Color(0xff00B181),
                //     Icons.check,
                //     white)
                    : Container(),
                selectDay(context, controller),
                controller.blockedSlot.isNotEmpty
                    ? getTileWidget(
                    context,
                    const Color(0xffFBE6E4),
                    controller.blockedSlot.isNotEmpty
                        ? getBlockSlotRichText(controller, context)
                        : Container(),
                    const Color(0xffFBE6E4),
                    Icons.block_flipped,
                    const Color(0xffEC766D))
                    : Container(),
                bottomButtons(context),
              ]),
            ),
          );
        });
  }

  RichText getBlockSlotRichText(
      ServiceTimingController controller, BuildContext context) {
    return RichText(
        text: TextSpan(
            text: "You blocked ",
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
            children: [
              TextSpan(
                children: List.generate(
                    controller.blockedSlot.length != 1
                        ? 1
                        : controller.blockedSlot.length,
                        (index) => TextSpan(children: [
                      TextSpan(
                          text: DateFormat('E, MMM d, y')
                              .format(controller.blockedSlot[index].date),
                          style: const TextStyle(color: black, fontSize: 16)),
                    ])),
              ),
              const TextSpan(
                  text: " : ",
                  style: TextStyle(
                      color: black, fontSize: 16, fontWeight: FontWeight.w400)),
              TextSpan(children: [
                TextSpan(
                    text:
                    "${converTimeFrom24Hour(controller.blockedSlot[0].fromTime, context)}",
                    style: const TextStyle(color: black, fontSize: 16)),
                const TextSpan(
                    text: " - ", style: TextStyle(color: black, fontSize: 16)),
                TextSpan(
                    text:
                    "${converTimeFrom24Hour(controller.blockedSlot[0].toTime, context)}",
                    style: const TextStyle(color: black, fontSize: 16)),
                TextSpan(
                    text: " ...more",
                    style: const TextStyle(color: Colors.blue, fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Iterable<BlockedSlot> _blockslot =
                        //     controller.blockedSlot;

                        Get.to(BlockServiceTiming.new);
                      })
              ]),
            ]));
  }

  getAvailableTimeSlot(
      ServiceTimingController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      "Preferred Availability ",
                      style: TextStyle(
                          color: Color(0xff151415),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          color: const Color(0xffE8F7F1),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Icon(
                        Icons.calendar_month_sharp,
                        size: 16,
                        color: Color(0xff00B181),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          Container(
                            width: Get.width * 0.6,
                            child: RichText(
                              text: TextSpan(
                                  text: "Days: ",
                                  style: const TextStyle(
                                      color: Color(0xff151415),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  children: List.generate(
                                      controller.scheduleElement.length,
                                          (index) => TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                            "${controller.scheduleElement[index].day.substring(0, 3)}",
                                            style: const TextStyle(
                                                color: Color(0xff00B181),
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),
                                          index ==
                                              controller.scheduleElement
                                                  .length -
                                                  1
                                              ? const TextSpan(text: " ")
                                              : const TextSpan(text: ", ")
                                        ],
                                        style: const TextStyle(
                                            color: Color(0xff151415),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ))),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(
                  color: Colors.black54,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          color: const Color(0xffE8F7F1),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Icon(
                        Icons.access_time_filled,
                        size: 16,
                        color: Color(
                          0xff00B181,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          controller.scheduleElement.length > 1
                              ? Container(
                            width: Get.width * 0.6,
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: List.generate(
                                    controller.scheduleElement.length,
                                        (index) => Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 42,
                                            child: Text(
                                              "${controller.scheduleElement[index].day.substring(0, 3)}: ",
                                              style: const TextStyle(
                                                  color: Color(
                                                      0xff555555),
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight
                                                      .w400),
                                            ),
                                          ),
                                          Text(
                                            "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
                                            style: const TextStyle(
                                                color:
                                                Color(0xff00B181),
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),
                                          const Text(
                                            " to ",
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w300),
                                          ),
                                          Text(
                                            "${converTimeFrom24Hour("${controller.scheduleElement[index].toTime}", context)} ",
                                            style: const TextStyle(
                                                color:
                                                Color(0xff00B181),
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),
                                          // index == controller.scheduleElement.length - 1
                                          //     ? const Text("")
                                          //     : const Text(
                                          //         "",
                                          //         style: TextStyle(
                                          //             color: Colors.black,
                                          //             fontSize: 18,
                                          //             fontWeight:
                                          //                 FontWeight.bold),
                                          //       ),
                                        ]))),
                          )
                          // Container(
                          //     width: Get.width * 0.6,
                          //     child: RichText(

                          //         text: TextSpan(
                          //             style: const TextStyle(
                          //                 color: Color(0xff151415),
                          //                 fontSize: 16,
                          //                 fontWeight: FontWeight.w400),
                          //             children: List.generate(
                          //                 controller.scheduleElement.length,
                          //                 (index) => TextSpan(children: [
                          //                       TextSpan(
                          //                         text:
                          //                             "${controller.scheduleElement[index].day!.substring(0, 3)}: ",
                          //                         style: const TextStyle(
                          //                             color: Color(0xff555555),
                          //                             fontSize: 16,
                          //                             fontWeight: FontWeight.w400),
                          //                       ),
                          //                       TextSpan(
                          //                         text:
                          //                             "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
                          //                         style: const TextStyle(
                          //                             color: Color(0xff00B181),
                          //                             fontSize: 16,
                          //                             fontWeight: FontWeight.w400),
                          //                       ),
                          //                       const TextSpan(
                          //                         text: " to ",
                          //                         style: TextStyle(
                          //                             color: Colors.black,
                          //                             fontSize: 16,
                          //                             fontWeight: FontWeight.w300),
                          //                       ),
                          //                       TextSpan(
                          //                         text:
                          //                             "${converTimeFrom24Hour("${controller.scheduleElement[index].toTime}", context)} ",
                          //                         style: const TextStyle(
                          //                             color: Color(0xff00B181),
                          //                             fontSize: 16,
                          //                             fontWeight: FontWeight.w400),
                          //                       ),
                          //                       index == controller.scheduleElement.length - 1
                          //                           ? const TextSpan()
                          //                           : const TextSpan(
                          //                               text: "\n",
                          //                               style: TextStyle(
                          //                                   color: Colors.black,
                          //                                   fontSize: 18,
                          //                                   fontWeight:
                          //                                       FontWeight.bold),
                          //                             ),
                          //                     ])))),
                          //   )
                              : Container(
                            width: Get.width * 0.6,
                            margin: EdgeInsets.only(top: 5),
                            child: RichText(
                                text: TextSpan(
                                    text: "Time: ",
                                    style: const TextStyle(
                                        color: Color(0xff151415),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    children: List.generate(
                                        controller.scheduleElement.length,
                                            (index) => TextSpan(children: [
                                          TextSpan(
                                            text:
                                            "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
                                            style: const TextStyle(
                                                color:
                                                Color(0xff00B181),
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),
                                          const TextSpan(
                                            text: " to ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),
                                          TextSpan(
                                            text:
                                            "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
                                            style: const TextStyle(
                                                color:
                                                Color(0xff00B181),
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),
                                          index ==
                                              controller
                                                  .scheduleElement
                                                  .length -
                                                  1
                                              ? const TextSpan()
                                              : const TextSpan(
                                            text: " : ",
                                            style: TextStyle(
                                                color: Colors
                                                    .black,
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight
                                                    .bold),
                                          ),
                                        ])))),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
    // Column(
    //   children: [
    //     RichText(
    //       text: TextSpan(
    //           text: "Preferred availability set to ",
    //           style: const TextStyle(color: black, fontSize: 16),
    //           children: controller.scheduleElement.length == 1
    //               ? []
    //               : [
    //                   TextSpan(
    //                     children: List.generate(
    //                         controller.scheduleElement.length,
    //                         (index) => TextSpan(children: [
    //                               TextSpan(
    //                                   text: controller
    //                                       .scheduleElement[index].day
    //                                       .substring(0, 3),
    //                                   style: const TextStyle(
    //                                       color: Color(0xff00B181),
    //                                       fontSize: 16)),
    //                               const TextSpan(
    //                                   text: ", ",
    //                                   style:
    //                                       TextStyle(color: black, fontSize: 16))
    //                             ])),
    //                   ),
    //                   const TextSpan(
    //                       text: " at ",
    //                       style: TextStyle(
    //                           color: black,
    //                           fontSize: 16,
    //                           fontWeight: FontWeight.w400)),
    //                   // TextSpan(
    //                   //     children: List.generate(
    //                   //         controller.scheduleElement.length,
    //                   //         (index) =>
    //                   //          TextSpan(children: [
    //                   //               TextSpan(
    //                   //                   text: controller.scheduleElement[index].day
    //                   //                       .substring(0, 3),
    //                   //                   // "${converTimeFrom24Hour(controller.scheduleElement[index].day, context)}",
    //                   //                   style: const TextStyle(
    //                   //                       color: Color(0xff00B181),
    //                   //                       fontSize: 16)),
    //                   //               TextSpan(
    //                   //                   text:
    //                   //                       " ${converTimeFrom24Hour(controller.scheduleElement[index].fromTime, context)}",
    //                   //                   style: const TextStyle(
    //                   //                       color: Color(0xff00B181),
    //                   //                       fontSize: 16)),
    //                   //               const TextSpan(
    //                   //                   text: " to ",
    //                   //                   style:
    //                   //                       TextStyle(color: black, fontSize: 16)),
    //                   //               TextSpan(
    //                   //                   text:
    //                   //                       "${converTimeFrom24Hour(controller.scheduleElement[index].toTime, context)}",
    //                   //                   style: const TextStyle(
    //                   //                       color: Color(0xff00B181),
    //                   //                       fontSize: 16)),
    //                   //               TextSpan(text: "\n")
    //                   //             ])
    //                   //             )),
    //                 ]),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(left: 12),
    //       child: Row(
    //         children: [
    //           controller.scheduleElement.length > 1
    //               ? Container(
    //                   // width: Get.width * 0.6,
    //                   child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: List.generate(
    //                           controller.scheduleElement.length,
    //                           (index) => Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.start,
    //                                   children: [
    //                                     SizedBox(
    //                                       width: 42,
    //                                       child: Text(
    //                                         "${controller.scheduleElement[index].day.substring(0, 3)}: ",
    //                                         style: const TextStyle(
    //                                             color: Color(0xff555555),
    //                                             fontSize: 16,
    //                                             fontWeight: FontWeight.w400),
    //                                       ),
    //                                     ),
    //                                     Text(
    //                                       "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
    //                                       style: const TextStyle(
    //                                           color: Color(0xff00B181),
    //                                           fontSize: 16,
    //                                           fontWeight: FontWeight.w400),
    //                                     ),
    //                                     const Text(
    //                                       " to ",
    //                                       style: TextStyle(
    //                                           color: Colors.black45,
    //                                           fontSize: 16,
    //                                           fontWeight: FontWeight.w300),
    //                                     ),
    //                                     Text(
    //                                       "${converTimeFrom24Hour("${controller.scheduleElement[index].toTime}", context)} ",
    //                                       style: const TextStyle(
    //                                           color: Color(0xff00B181),
    //                                           fontSize: 16,
    //                                           fontWeight: FontWeight.w400),
    //                                     ),
    //                                     // index == controller.scheduleElement.length - 1
    //                                     //     ? const Text("")
    //                                     //     : const Text(
    //                                     //         "",
    //                                     //         style: TextStyle(
    //                                     //             color: Colors.black,
    //                                     //             fontSize: 18,
    //                                     //             fontWeight:
    //                                     //                 FontWeight.bold),
    //                                     //       ),
    //                                   ]))),
    //                 )
    //               // Container(
    //               //     width: Get.width * 0.6,
    //               //     child: RichText(

    //               //         text: TextSpan(
    //               //             style: const TextStyle(
    //               //                 color: Color(0xff151415),
    //               //                 fontSize: 16,
    //               //                 fontWeight: FontWeight.w400),
    //               //             children: List.generate(
    //               //                 controller.scheduleElement.length,
    //               //                 (index) => TextSpan(children: [
    //               //                       TextSpan(
    //               //                         text:
    //               //                             "${controller.scheduleElement[index].day!.substring(0, 3)}: ",
    //               //                         style: const TextStyle(
    //               //                             color: Color(0xff555555),
    //               //                             fontSize: 16,
    //               //                             fontWeight: FontWeight.w400),
    //               //                       ),
    //               //                       TextSpan(
    //               //                         text:
    //               //                             "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
    //               //                         style: const TextStyle(
    //               //                             color: Color(0xff00B181),
    //               //                             fontSize: 16,
    //               //                             fontWeight: FontWeight.w400),
    //               //                       ),
    //               //                       const TextSpan(
    //               //                         text: " to ",
    //               //                         style: TextStyle(
    //               //                             color: Colors.black,
    //               //                             fontSize: 16,
    //               //                             fontWeight: FontWeight.w300),
    //               //                       ),
    //               //                       TextSpan(
    //               //                         text:
    //               //                             "${converTimeFrom24Hour("${controller.scheduleElement[index].toTime}", context)} ",
    //               //                         style: const TextStyle(
    //               //                             color: Color(0xff00B181),
    //               //                             fontSize: 16,
    //               //                             fontWeight: FontWeight.w400),
    //               //                       ),
    //               //                       index == controller.scheduleElement.length - 1
    //               //                           ? const TextSpan()
    //               //                           : const TextSpan(
    //               //                               text: "\n",
    //               //                               style: TextStyle(
    //               //                                   color: Colors.black,
    //               //                                   fontSize: 18,
    //               //                                   fontWeight:
    //               //                                       FontWeight.bold),
    //               //                             ),
    //               //                     ])))),
    //               //   )
    //               : Container(
    //                   // width: Get.width * 0.6,
    //                   margin: EdgeInsets.only(top: 5),
    //                   child: RichText(
    //                       text: TextSpan(
    //                           text: "Time: ",
    //                           style: const TextStyle(
    //                               color: Color(0xff151415),
    //                               fontSize: 16,
    //                               fontWeight: FontWeight.w400),
    //                           children: List.generate(
    //                               controller.scheduleElement.length,
    //                               (index) => TextSpan(children: [
    //                                     TextSpan(
    //                                       text:
    //                                           "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
    //                                       style: const TextStyle(
    //                                           color: Color(0xff00B181),
    //                                           fontSize: 16,
    //                                           fontWeight: FontWeight.w400),
    //                                     ),
    //                                     const TextSpan(
    //                                       text: " to ",
    //                                       style: TextStyle(
    //                                           color: Colors.black,
    //                                           fontSize: 16,
    //                                           fontWeight: FontWeight.w400),
    //                                     ),
    //                                     TextSpan(
    //                                       text:
    //                                           "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
    //                                       style: const TextStyle(
    //                                           color: Color(0xff00B181),
    //                                           fontSize: 16,
    //                                           fontWeight: FontWeight.w400),
    //                                     ),
    //                                     index ==
    //                                             controller.scheduleElement
    //                                                     .length -
    //                                                 1
    //                                         ? const TextSpan()
    //                                         : const TextSpan(
    //                                             text: " : ",
    //                                             style: TextStyle(
    //                                                 color: Colors.black,
    //                                                 fontSize: 18,
    //                                                 fontWeight:
    //                                                     FontWeight.bold),
    //                                           ),
    //                                   ])))),
    //                 ),
    //         ],
    //       ),
    //     )
    //   ],
    // );
  }

  bottomButtons(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      alignment: Alignment.center,
      child: FittedBox(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          10.height,
          AppButton(
            shapeBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            onTap: () {
              if (serviceTimingController.scheduleElement.isNotEmpty) {
                Get.to(BlockServiceTiming.new, fullscreenDialog: true);
              } else {
                Get.snackbar("Select time",
                    "Please first set the time inorder to block specific time it");
              }
            },
            width: Get.width,
            height: 50,
            color: const Color(0xff0068E1),
            child: Text(
              "Block specific time & date",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: white, fontWeight: FontWeight.w500),
            ),
          ),
          20.height,
          AppButton(
            shapeBorder: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xff0068E1)),
                borderRadius: BorderRadius.circular(18)),
            onTap: () {
              if (serviceTimingController.scheduleElement.isNotEmpty) {
                Get.to(CustomizeServiceTiming.new);
              } else {
                Get.snackbar("Select time",
                    "Please first set the time inorder to customize it");
              }
            },
            width: Get.width,
            height: 50,
            color: Colors.grey.shade200,
            child: Text(
              "Customize Availability",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color(0xff0068E1), fontWeight: FontWeight.w500),
            ),
          ),
          // 20.height,
        ]),
      ),
    );
  }

  blockSection(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Card(
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              // color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(13)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.block,
                                color: Colors.red.shade300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.centerLeft,
                      child: ListView(
                        children: [
                          ReadMoreText(
                            'You blocked Tue, Wed, Thu, Fri, at 10:00 AM to 04:00 PM "Availablity set to Mon, Tue, Wed, Thu, Fri, at 10:00 AM to 04:00 PM ',
                            trimLines: 2,
                            trimLength: 40,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Length,
                            trimCollapsedText: 'show more',
                            trimExpandedText: '...show less',

                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(),

                            // lessStyle: TextStyle(
                            //     fontSize: 14, fontWeight: FontWeight.bold),
                            // moreStyle: TextStyle(
                            //     fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ))
              ]),
            ),
          ),
        ));
  }

  selectDay(BuildContext context, ServiceTimingController controller) {
    return Container(
        width: double.infinity,
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Day \& Time",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: DropDownOFServiceTiming(flag: "start")),
                  10.width,
                  Text(
                    "TO",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.black45, fontWeight: FontWeight.w400),
                  ),
                  10.width,
                  Flexible(child: DropDownOFServiceTiming(flag: "end"),)
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GetBuilder<ChooseTimeDialogController>(
                        init: ChooseTimeDialogController(),
                        builder: (choosecontroller) {
                          return AppButton(
                            color: _grey,
                            elevation: 0,
                            width: 140,
                            height: 47,
                            shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            onTap: () {
                              // DatePicker.showTimePicker(context, showTitleActions: true,
                              //     onChanged: (date) {
                              //       dateController.startTime.value=date.toString().split(' ').last.split('.').first;
                              //     }, onConfirm: (date) {
                              //       dateController.startTime.value=date.toString().split(' ').last.split('.').first;
                              //     }, currentTime: DateTime.now());

                              Get.dialog(ChooseTimeDialog(
                                  text: "Start",
                                  okTap: () {
                                    var value = choosecontroller
                                        .setSeelctedValue(context);
                                    if (value != null) {
                                      controller.setStartTime(value);
                                      Get.back();
                                    }
                                  },
                                  chooseTimeDialogController:
                                  choosecontroller));
                            },
                            child:
                            // Obx(()=>Text(dateController.startTime.value,style: Theme.of(context)
                            //       .textTheme
                            //       .titleSmall!
                            //       .copyWith(
                            //           color: Colors.black87,
                            //           fontWeight: FontWeight.w500),))
                            Text(
                              controller.selectedStartTime
                                  .contains("Select Time")
                                  ? "Select Time"
                                  : "${converTimeFrom24Hour(controller.selectedStartTime, context)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                  color: controller.selectedStartTime
                                      .contains("Select Time")
                                      ? Colors.black54
                                      : Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        }),
                    10.width,
                    Text(
                      "TO",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black45, fontWeight: FontWeight.w400),
                    ),
                    10.width,
                    GetBuilder<ChooseTimeDialogController>(
                        init: ChooseTimeDialogController(),
                        builder: (choosecontroller) {
                          return AppButton(
                            color: _grey,
                            elevation: 0,
                            width: 140,
                            height: 47,
                            shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            onTap: () {
                              Get.dialog(
                                  ChooseTimeDialogNew(
                                  text: "End",
                                  okTap: () {
                                    var value = choosecontroller
                                        .setEndSeelctedValue(context);
                                    if (value != null) {
                                      controller.setEndTime(value);
                                      Get.back();
                                    }
                                  },
                                  chooseTimeDialogController:
                                  choosecontroller));
                              // DatePicker.showTimePicker(context, showTitleActions: true,
                              //     onChanged: (date) {
                              //       dateController.endTime.value=date.toString().split(' ').last.split('.').first;
                              //     }, onConfirm: (date) {
                              //       dateController.endTime.value=date.toString().split(' ').last.split('.').first;
                              //     }, currentTime: DateTime.now());
                            },
                            child:
                            // Obx(()=>Text(dateController.endTime.value,style: Theme.of(context)
                            //     .textTheme
                            //     .titleSmall!
                            //     .copyWith(
                            //     color: Colors.black87,
                            //     fontWeight: FontWeight.w500),))

                            Text(
                              controller.selectedEndTime.contains("Select Time")
                                  ? controller.selectedEndTime
                                  : "${converTimeFrom24Hour(controller.selectedEndTime, context)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                  color: controller.selectedEndTime
                                      .contains("Select Time")
                                      ? Colors.black54
                                      : Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  getTileWidget(BuildContext context, Color color, Widget text, Color iconback,
      IconData iconData, Color iconColor) {
    return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Card(
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(20)),
              child:
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(13)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: iconback, shape: BoxShape.circle),
                          child: FittedBox(
                            child: Icon(
                              iconData,
                              color: iconColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(
                            right: 32, left: 5, bottom: 12, top: 12),
                        alignment: Alignment.topLeft,
                        child: text
                      //  ReadMoreText(
                      //   text,
                      //   trimLines: 2,
                      //   colorClickableText: Colors.pink,
                      //   trimMode: TrimMode.Line,
                      //   trimCollapsedText: 'show more',
                      //   trimExpandedText: '...show less',
                      //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      //       fontSize: 16,
                      //       color: Color(0xff323032),
                      //       fontWeight: FontWeight.w400),
                      //   lessStyle: TextStyle(
                      //       fontSize: 14, fontWeight: FontWeight.w400),
                      //   moreStyle: TextStyle(
                      //       fontSize: 14, fontWeight: FontWeight.w400),
                      // ),

                    ))
              ]),
            ),
          ),
        ));
  }

  topTextWidget(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 80,
        child: FittedBox(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Set your preffered Availablity",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      fontSize: 26),
                ),
                Text(
                  "Your availablity is set to completely \n available by default.",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.black45,
                      fontSize: 20),
                ),
              ]),
        ));
  }
}

getAvailableTimeSlot(ServiceTimingController controller, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Preferred Availability",
                    style: TextStyle(
                        color: Color(0xff151415),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: const Color(0xffE8F7F1),
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(
                      Icons.calendar_month_sharp,
                      size: 16,
                      color: Color(0xff00B181),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Container(
                          width: Get.width * 0.6,
                          child: RichText(
                            text: TextSpan(
                                text: "Days: ",
                                style: const TextStyle(
                                    color: Color(0xff151415),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                                children: List.generate(
                                    controller.scheduleElement.length,
                                        (index) => TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                          "${controller.scheduleElement[index].day.substring(0, 3)}",
                                          style: const TextStyle(
                                              color: Color(0xff00B181),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        index ==
                                            controller.scheduleElement
                                                .length -
                                                1
                                            ? const TextSpan(text: " ")
                                            : const TextSpan(text: ", ")
                                      ],
                                      style: const TextStyle(
                                          color: Color(0xff151415),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ))),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const Divider(
                color: Colors.black54,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: const Color(0xffE8F7F1),
                        borderRadius: BorderRadius.circular(6)),
                    child: const Icon(
                      Icons.access_time_filled,
                      size: 16,
                      color: Color(
                        0xff00B181,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        controller.scheduleElement.length > 1
                            ? Container(
                          width: Get.width * 0.6,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                  controller.scheduleElement.length,
                                      (index) => Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 42,
                                          child: Text(
                                            "${controller.scheduleElement[index].day.substring(0, 3)}: ",
                                            style: const TextStyle(
                                                color:
                                                Color(0xff555555),
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),
                                        ),
                                        Text(
                                          "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
                                          style: const TextStyle(
                                              color:
                                              Color(0xff00B181),
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.w400),
                                        ),
                                        const Text(
                                          " to ",
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.w300),
                                        ),
                                        Text(
                                          "${converTimeFrom24Hour("${controller.scheduleElement[index].toTime}", context)} ",
                                          style: const TextStyle(
                                              color:
                                              Color(0xff00B181),
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.w400),
                                        ),
                                        // index == controller.scheduleElement.length - 1
                                        //     ? const Text("")
                                        //     : const Text(
                                        //         "",
                                        //         style: TextStyle(
                                        //             color: Colors.black,
                                        //             fontSize: 18,
                                        //             fontWeight:
                                        //                 FontWeight.bold),
                                        //       ),
                                      ]))),
                        )
                        // Container(
                        //     width: Get.width * 0.6,
                        //     child: RichText(

                        //         text: TextSpan(
                        //             style: const TextStyle(
                        //                 color: Color(0xff151415),
                        //                 fontSize: 16,
                        //                 fontWeight: FontWeight.w400),
                        //             children: List.generate(
                        //                 controller.scheduleElement.length,
                        //                 (index) => TextSpan(children: [
                        //                       TextSpan(
                        //                         text:
                        //                             "${controller.scheduleElement[index].day!.substring(0, 3)}: ",
                        //                         style: const TextStyle(
                        //                             color: Color(0xff555555),
                        //                             fontSize: 16,
                        //                             fontWeight: FontWeight.w400),
                        //                       ),
                        //                       TextSpan(
                        //                         text:
                        //                             "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
                        //                         style: const TextStyle(
                        //                             color: Color(0xff00B181),
                        //                             fontSize: 16,
                        //                             fontWeight: FontWeight.w400),
                        //                       ),
                        //                       const TextSpan(
                        //                         text: " to ",
                        //                         style: TextStyle(
                        //                             color: Colors.black,
                        //                             fontSize: 16,
                        //                             fontWeight: FontWeight.w300),
                        //                       ),
                        //                       TextSpan(
                        //                         text:
                        //                             "${converTimeFrom24Hour("${controller.scheduleElement[index].toTime}", context)} ",
                        //                         style: const TextStyle(
                        //                             color: Color(0xff00B181),
                        //                             fontSize: 16,
                        //                             fontWeight: FontWeight.w400),
                        //                       ),
                        //                       index == controller.scheduleElement.length - 1
                        //                           ? const TextSpan()
                        //                           : const TextSpan(
                        //                               text: "\n",
                        //                               style: TextStyle(
                        //                                   color: Colors.black,
                        //                                   fontSize: 18,
                        //                                   fontWeight:
                        //                                       FontWeight.bold),
                        //                             ),
                        //                     ])))),
                        //   )
                            : Container(
                          width: Get.width * 0.6,
                          margin: EdgeInsets.only(top: 5),
                          child: RichText(
                              text: TextSpan(
                                  text: "Time: ",
                                  style: const TextStyle(
                                      color: Color(0xff151415),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  children: List.generate(
                                      controller.scheduleElement.length,
                                          (index) => TextSpan(children: [
                                        TextSpan(
                                          text:
                                          "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
                                          style: const TextStyle(
                                              color:
                                              Color(0xff00B181),
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.w400),
                                        ),
                                        const TextSpan(
                                          text: " to ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.w400),
                                        ),
                                        TextSpan(
                                          text:
                                          "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
                                          style: const TextStyle(
                                              color:
                                              Color(0xff00B181),
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.w400),
                                        ),
                                        index ==
                                            controller
                                                .scheduleElement
                                                .length -
                                                1
                                            ? const TextSpan()
                                            : const TextSpan(
                                          text: " : ",
                                          style: TextStyle(
                                              color:
                                              Colors.black,
                                              fontSize: 18,
                                              fontWeight:
                                              FontWeight
                                                  .bold),
                                        ),
                                      ])))),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ]),
      ),
    ),
  );

}
// Column(
//   children: [
//     RichText(
//       text: TextSpan(
//           text: "Preferred availability set to ",
//           style: const TextStyle(color: black, fontSize: 16),
//           children: controller.scheduleElement.length == 1
//               ? []
//               : [
//                   TextSpan(
//                     children: List.generate(
//                         controller.scheduleElement.length,
//                         (index) => TextSpan(children: [
//                               TextSpan(
//                                   text: controller
//                                       .scheduleElement[index].day
//                                       .substring(0, 3),
//                                   style: const TextStyle(
//                                       color: Color(0xff00B181),
//                                       fontSize: 16)),
//                               const TextSpan(
//                                   text: ", ",
//                                   style:
//                                       TextStyle(color: black, fontSize: 16))
//                             ])),
//                   ),
//                   const TextSpan(
//                       text: " at ",
//                       style: TextStyle(
//                           color: black,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400)),
//                   // TextSpan(
//                   //     children: List.generate(
//                   //         controller.scheduleElement.length,
//                   //         (index) =>
//                   //          TextSpan(children: [
//                   //               TextSpan(
//                   //                   text: controller.scheduleElement[index].day
//                   //                       .substring(0, 3),
//                   //                   // "${converTimeFrom24Hour(controller.scheduleElement[index].day, context)}",
//                   //                   style: const TextStyle(
//                   //                       color: Color(0xff00B181),
//                   //                       fontSize: 16)),
//                   //               TextSpan(
//                   //                   text:
//                   //                       " ${converTimeFrom24Hour(controller.scheduleElement[index].fromTime, context)}",
//                   //                   style: const TextStyle(
//                   //                       color: Color(0xff00B181),
//                   //                       fontSize: 16)),
//                   //               const TextSpan(
//                   //                   text: " to ",
//                   //                   style:
//                   //                       TextStyle(color: black, fontSize: 16)),
//                   //               TextSpan(
//                   //                   text:
//                   //                       "${converTimeFrom24Hour(controller.scheduleElement[index].toTime, context)}",
//                   //                   style: const TextStyle(
//                   //                       color: Color(0xff00B181),
//                   //                       fontSize: 16)),
//                   //               TextSpan(text: "\n")
//                   //             ])
//                   //             )),
//                 ]),
//     ),
//     Padding(
//       padding: const EdgeInsets.only(left: 12),
//       child: Row(
//         children: [
//           controller.scheduleElement.length > 1
//               ? Container(
//                   // width: Get.width * 0.6,
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: List.generate(
//                           controller.scheduleElement.length,
//                           (index) => Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       width: 42,
//                                       child: Text(
//                                         "${controller.scheduleElement[index].day.substring(0, 3)}: ",
//                                         style: const TextStyle(
//                                             color: Color(0xff555555),
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w400),
//                                       ),
//                                     ),
//                                     Text(
//                                       "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
//                                       style: const TextStyle(
//                                           color: Color(0xff00B181),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                     const Text(
//                                       " to ",
//                                       style: TextStyle(
//                                           color: Colors.black45,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w300),
//                                     ),
//                                     Text(
//                                       "${converTimeFrom24Hour("${controller.scheduleElement[index].toTime}", context)} ",
//                                       style: const TextStyle(
//                                           color: Color(0xff00B181),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                     // index == controller.scheduleElement.length - 1
//                                     //     ? const Text("")
//                                     //     : const Text(
//                                     //         "",
//                                     //         style: TextStyle(
//                                     //             color: Colors.black,
//                                     //             fontSize: 18,
//                                     //             fontWeight:
//                                     //                 FontWeight.bold),
//                                     //       ),
//                                   ]))),
//                 )
//               // Container(
//               //     width: Get.width * 0.6,
//               //     child: RichText(

//               //         text: TextSpan(
//               //             style: const TextStyle(
//               //                 color: Color(0xff151415),
//               //                 fontSize: 16,
//               //                 fontWeight: FontWeight.w400),
//               //             children: List.generate(
//               //                 controller.scheduleElement.length,
//               //                 (index) => TextSpan(children: [
//               //                       TextSpan(
//               //                         text:
//               //                             "${controller.scheduleElement[index].day!.substring(0, 3)}: ",
//               //                         style: const TextStyle(
//               //                             color: Color(0xff555555),
//               //                             fontSize: 16,
//               //                             fontWeight: FontWeight.w400),
//               //                       ),
//               //                       TextSpan(
//               //                         text:
//               //                             "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
//               //                         style: const TextStyle(
//               //                             color: Color(0xff00B181),
//               //                             fontSize: 16,
//               //                             fontWeight: FontWeight.w400),
//               //                       ),
//               //                       const TextSpan(
//               //                         text: " to ",
//               //                         style: TextStyle(
//               //                             color: Colors.black,
//               //                             fontSize: 16,
//               //                             fontWeight: FontWeight.w300),
//               //                       ),
//               //                       TextSpan(
//               //                         text:
//               //                             "${converTimeFrom24Hour("${controller.scheduleElement[index].toTime}", context)} ",
//               //                         style: const TextStyle(
//               //                             color: Color(0xff00B181),
//               //                             fontSize: 16,
//               //                             fontWeight: FontWeight.w400),
//               //                       ),
//               //                       index == controller.scheduleElement.length - 1
//               //                           ? const TextSpan()
//               //                           : const TextSpan(
//               //                               text: "\n",
//               //                               style: TextStyle(
//               //                                   color: Colors.black,
//               //                                   fontSize: 18,
//               //                                   fontWeight:
//               //                                       FontWeight.bold),
//               //                             ),
//               //                     ])))),
//               //   )
//               : Container(
//                   // width: Get.width * 0.6,
//                   margin: EdgeInsets.only(top: 5),
//                   child: RichText(
//                       text: TextSpan(
//                           text: "Time: ",
//                           style: const TextStyle(
//                               color: Color(0xff151415),
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400),
//                           children: List.generate(
//                               controller.scheduleElement.length,
//                               (index) => TextSpan(children: [
//                                     TextSpan(
//                                       text:
//                                           "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
//                                       style: const TextStyle(
//                                           color: Color(0xff00B181),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                     const TextSpan(
//                                       text: " to ",
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                     TextSpan(
//                                       text:
//                                           "${converTimeFrom24Hour("${controller.scheduleElement[index].fromTime}", context)} ",
//                                       style: const TextStyle(
//                                           color: Color(0xff00B181),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                     index ==
//                                             controller.scheduleElement
//                                                     .length -
//                                                 1
//                                         ? const TextSpan()
//                                         : const TextSpan(
//                                             text: " : ",
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 18,
//                                                 fontWeight:
//                                                     FontWeight.bold),
//                                           ),
//                                   ])))),
//                 ),
//         ],
//       ),
//     )
//   ],
// );