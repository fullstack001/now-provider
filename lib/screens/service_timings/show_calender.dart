import 'package:fare_now_provider/screens/service_timings/controller/block_timing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../custom_packages/calendar/customization/calendar_style.dart';
import '../../custom_packages/calendar/customization/header_style.dart';
import '../../custom_packages/calendar/table_calendar.dart';
import '../../controllers/profile_screen_controller/ProfileScreenController.dart';

class ShowCalenderWidget extends StatelessWidget {
  int index;
  ShowCalenderWidget({required this.index});
  ProfileScreenController _profileScreenController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlockTimingController>(
        init: BlockTimingController(),
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.82,
                height: Get.width * 1.2,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.firstDay.year}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                            10.height,
                            Text(
                              "${DateFormat('E, MMM d').format(controller.firstDay)}",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            )
                          ]),
                    ),
                    TableCalendar(
                      rowHeight: 36,
                      timeList: _profileScreenController
                          .providerTiming.value.timingDatesData,
                      calendarStyle: CalendarStyle(
                          canMarkersOverflow: true,
                          outsideDaysVisible: true,
                          isTodayHighlighted: true,
                          markersAutoAligned: true,
                          todayDecoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blue, width: 1)),
                          withinRangeDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          weekendDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          rangeStartDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          rangeEndDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          outsideDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          holidayDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          disabledDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          defaultDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          cellMargin: EdgeInsets.all(5),
                          markerDecoration: BoxDecoration(
                              color: Colors.red,
                              border:
                                  Border.all(color: Colors.black, width: 1))),
                      firstDay: DateTime.now(),
                      lastDay: DateTime.utc(2050, 1, 1),
                      focusedDay: controller.firstDay,
                      currentDay: controller.firstDay,
                      headerStyle: HeaderStyle(
                        decoration: BoxDecoration(),
                        leftChevronIcon: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Color(0xff0068E1))),
                            child: Icon(Icons.chevron_left_sharp,
                                color: Color(0xff0068E1))),
                        formatButtonVisible: false,
                        rightChevronIcon: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Color(0xff0068E1))),
                            child: Icon(Icons.chevron_right_outlined,
                                color: Colors.white)),
                        titleCentered: true,
                        formatButtonDecoration: BoxDecoration(),
                        formatButtonPadding: EdgeInsets.all(6),
                        formatButtonShowsNext: false,
                      ),
                      onDaySelected: (v, vh) {
                        controller.updateFirstDay(v);
                      },
                    ),
                    rowOfDialogButton(controller, index)
                  ],
                ),
              ),
            ],
          );
        });
  }

  Row rowOfDialogButton(BlockTimingController controller, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        textButtonForDialog(() {
          Get.back();
        }, "Cancel"),
        textButtonForDialog(() {
          controller.setSelectedDate(
              index, BlockTime(date: controller.firstDay, stime: ""));
          Get.back();
        }, "Ok"),
      ],
    );
  }

  AppButton textButtonForDialog(Function onTap, String text) {
    return AppButton(
      onTap: onTap,
      color: Colors.white,
      elevation: 0,
      child: Text(
        "$text",
        style: TextStyle(
            color: Colors.blue.shade400,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  getDay(int weekday) {
    switch (weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";

      default:
        return "";
    }
  }

  getMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";

      case 2:
        return "Feb";

      case 3:
        return "Mar";

      case 4:
        return "April";

      case 5:
        return "May";

      case 6:
        return "June";

      case 7:
        return "July";

      case 8:
        return "Aug";

      case 9:
        return "Sep";

      case 10:
        return "Oct";

      case 11:
        return "Nov";

      case 12:
        return "Dec";

      default:
    }
  }
}
