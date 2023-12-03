import 'package:fare_now_provider/custom_packages/calendar/customization/calendar_style.dart';
import 'package:fare_now_provider/custom_packages/calendar/customization/header_style.dart';
import 'package:fare_now_provider/custom_packages/calendar/table_calendar.dart';
import 'package:fare_now_provider/controllers/profile_screen_controller/ProfileScreenController.dart';
import 'package:fare_now_provider/models/calender_events/fixed_times.dart';
import 'package:fare_now_provider/models/calender_events/time_slots.dart';
import 'package:fare_now_provider/models/calender_events/timing_dates_data.dart';
import 'package:fare_now_provider/models/time_slots/dates.dart';
import 'package:fare_now_provider/models/time_slots/slots.dart';
import 'package:fare_now_provider/models/time_slots/slots_response.dart';
import 'package:fare_now_provider/util/app_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../portfolio_controller.dart';

class ServiceTimings extends StatefulWidget {
  ServiceTimings({Key? key}) : super(key: key);

  @override
  _ServiceTimingsState createState() => _ServiceTimingsState();
}

class _ServiceTimingsState extends State<ServiceTimings> {
  DateTime _firstDay = DateTime.now();
  PortfolioController? _portfolioController = Get.put(PortfolioController());
  List<int> _selectedButtonIndex = [];
  bool isTaped = false;
  List<FixedTimes> timeList = getDates(
      year: DateTime.now().year,
      month: DateTime.now().month,
      date: DateTime.now().day);
  ProfileScreenController _profileScreenController = Get.find();

  static List<FixedTimes> getDates({month, year, date}) {
    ProfileScreenController cont = Get.find();
    DateTime now = new DateTime.now();

    List<FixedTimes> times = [
      FixedTimes(
          time: "00:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "01:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "02:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "03:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "04:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "05:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "06:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "07:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "08:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "09:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "10:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "11:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "12:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "13:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "14:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "15:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "16:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "17:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "18:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "19:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "20:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "21:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "22:00", date: date, year: year, month: month, selected: false),
      FixedTimes(
          time: "23:00", date: date, year: year, month: month, selected: false),
    ];

    for (int index = 0;
        index < cont.providerTiming.value.timingDatesData.length;
        index++) {
      if (cont.providerTiming.value.timingDatesData[index].year ==
              year.toString() &&
          // ignore: unrelated_type_equality_checks
          cont.providerTiming.value.timingDatesData[index].month ==
              month.toString() &&
          // ignore: unrelated_type_equality_checks
          cont.providerTiming.value.timingDatesData[index].date ==
              date.toString()) {
        print(cont.providerTiming.value.timingDatesData[index].date);
        for (int indexJ = 0; indexJ < times.length; indexJ++) {
          if (exist(times[indexJ].time!,
              cont.providerTiming.value.timingDatesData[index].timeSlots)) {
            times[indexJ].selected = true;
          } else {
            times[indexJ].selected = false;
          }
        }
      }
    }

    return times;
  }

  @override
  Widget build(BuildContext context) {
    // timeList = getDates();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Services Timings",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select  Available Date",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            TableCalendar(
              rowHeight: 36,
              timeList:
                  _profileScreenController.providerTiming.value.timingDatesData,
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
                      border: Border.all(color: Colors.black, width: 1)),
                  weekendDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  rangeStartDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  rangeEndDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  outsideDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  holidayDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  disabledDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  defaultDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  cellMargin: EdgeInsets.all(5),
                  markerDecoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(color: Colors.black, width: 1))),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              // availableCalendarFormats: {
              //   CalendarFormat.month: "June",
              // },
              focusedDay: _firstDay,
              currentDay: _firstDay,
              headerStyle: HeaderStyle(
                decoration: BoxDecoration(),
                formatButtonVisible: false,
                titleCentered: true,
                formatButtonDecoration: BoxDecoration(),
                formatButtonPadding: EdgeInsets.all(6),
                formatButtonShowsNext: false,
              ),
              onDaySelected: (v, vh) {
                int days = (DateTime.now().difference(v)).inDays;
                _firstDay = v;
                setState(() {
                  if (days <= 0) {
                    timeList = getDates(
                        year: _firstDay.year,
                        month: _firstDay.month,
                        date: _firstDay.day);
                    _selectedButtonIndex.clear();
                    setState(() {});
                  }
                });
              },
            ),
            Expanded(
                child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      flex: 0,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Select Available Time",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: gridViews(
                      columnSpan: 4,
                      itemCount: timeList.length,
                      builder: (int index, int span) {
                        return GestureDetector(
                          onTap: () {
                            print("${timeList[index].time}");
                            isTaped = true;
                            timeList[index].selected =
                                !timeList[index].selected!;

                            setDate(_profileScreenController, index);

                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: (Get.width - 35) / span,
                            padding: EdgeInsets.all(0),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(6),
                                width: Get.width / span,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  color: (timeList[index].selected ?? false)
                                      ? Colors.blue
                                      : Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      timeList[index].time!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            (timeList[index].selected ?? false)
                                                ? Colors.white70
                                                : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    /*ListView(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: GroupButton(
                          selectedButtons: _selectedButtonIndex,
                          borderRadius: BorderRadius.circular(5),
                          selectedColor: Colors.blue,
                          isRadio: false,
                          spacing: 8,
                          crossGroupAlignment: CrossGroupAlignment.center,
                          onSelected: (index, isSelected) {
                            setState(() {
                              _selectedButtonIndex.add(index);
                            });
                          },
                          buttons: getTimes(),
                        ),
                      ),
                    ],
                  )*/
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      flex: 0,
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: MaterialButton(
                            onPressed: () {
                              int days =
                                  (DateTime.now().difference(_firstDay)).inDays;
                              if (days <= 0) {
                                setState(() {
                                  if (_profileScreenController.providerTiming
                                      .value.timingDatesData.isNotEmpty) {
                                    SlotsResponse _slotResponse = getData();

                                    var data = _slotResponse.toJson();
                                    _profileScreenController.setTimes(
                                        body: data,
                                        controller: _profileScreenController);
                                    print("abc");
                                  }

                                  // _selectedButtonIndex.clear();
                                });
                              }
                            },
                            color:
                                (DateTime.now().difference(_firstDay)).inDays <=
                                        0
                                    ? Colors.green
                                    : Colors.grey,
                            textColor: Colors.white,
                            minWidth: MediaQuery.of(context).size.width * 0.8,
                            height: 47,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Save Details",
                              style: TextStyle(fontSize: 16),
                            ),
                          )))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  List<String> getTimes() {
    List<String> times = [];
    for (int index = 0; index < timeList.length; index++) {
      times.add(timeList[index].time!);
    }
    return times;
  }

  static bool exist(String time, var timeSlots) {
    for (int index = 0; index < timeSlots.length; index++) {
      if (timeSlots[index].start == time) {
        return true;
      }
    }
    return false;
  }

  void setDate(ProfileScreenController pro, int inde) {
    if (isTaped) {
      if (timeList[inde].selected!) {
        if (dateExist(pro, inde)) {
          for (int index = 0;
              index < pro.providerTiming.value.timingDatesData.length;
              index++) {
            String month =
                pro.providerTiming.value.timingDatesData[index].month;
            String year = pro.providerTiming.value.timingDatesData[index].year;
            String date = pro.providerTiming.value.timingDatesData[index].date;

            if (timeList[inde].month.toString() == month &&
                timeList[inde].year.toString() == year &&
                timeList[inde].date.toString() == date) {
              TimeSlots timeSlots = TimeSlots();
              timeSlots.start = timeList[inde].time;
              if ((inde + 1) < timeList.length) {
                timeSlots.end = timeList[inde + 1].time;
              }
              pro.providerTiming.value.timingDatesData[index].timeSlots
                  .add(timeSlots);
              print("");
              isTaped = false;
              break;
            }
          }
        } else {
          TimingDatesData data = TimingDatesData();
          data.month = timeList[inde].month.toString();
          data.date = timeList[inde].date.toString();
          data.year = timeList[inde].year.toString();
          data.timeSlots = [];
          TimeSlots slots = TimeSlots();
          slots.start = timeList[inde].time;
          if ((inde + 1) < timeList.length) {
            slots.end = timeList[inde - 1].time;
          }
          data.timeSlots.add(slots);
          pro.providerTiming.value.timingDatesData.add(data);

          print("");
        }
      } else {
        for (int index = 0;
            index < pro.providerTiming.value.timingDatesData.length;
            index++) {
          for (int indexSlot = 0;
              indexSlot <
                  pro.providerTiming.value.timingDatesData[index].timeSlots
                      .length;
              indexSlot++) {
            String slotYear = pro.providerTiming.value.timingDatesData[index]
                .timeSlots[indexSlot].start;
            String selectedTime = timeList[inde].time!;
            if (slotYear == selectedTime) {
              pro.providerTiming.value.timingDatesData[index].timeSlots
                  .removeAt(indexSlot);
              break;
            }
          }
          print("");
          isTaped = false;
          break;
        }
      }
    }
  }

  bool dateExist(ProfileScreenController pro, int inde) {
    for (int index = 0;
        index < pro.providerTiming.value.timingDatesData.length;
        index++) {
      String month = pro.providerTiming.value.timingDatesData[index].month;
      String year = pro.providerTiming.value.timingDatesData[index].year;
      String date = pro.providerTiming.value.timingDatesData[index].date;

      if (timeList[inde].month.toString() == month &&
          timeList[inde].year.toString() == year &&
          timeList[inde].date.toString() == date) {
        return true;
      }
    }
    return false;
  }

  SlotsResponse getData() {
    SlotsResponse _slotsResponse = SlotsResponse();
    String date = DateTime.now().day.toString();
    String month = DateTime.now().month.toString();
    String year = DateTime.now().year.toString();
    _slotsResponse.dates = [];
    for (int index = 0;
        index <
            _profileScreenController
                .providerTiming.value.timingDatesData.length;
        index++) {
      String modelYear = _profileScreenController
          .providerTiming.value.timingDatesData[index].year;
      String modelMonth = _profileScreenController
          .providerTiming.value.timingDatesData[index].month;
      String modelDate = _profileScreenController
          .providerTiming.value.timingDatesData[index].date;

      var timeSlot = _profileScreenController
          .providerTiming.value.timingDatesData[index].timeSlots;

      if (year == modelYear && month == modelMonth) {
        _slotsResponse.year = DateTime.now().year;
        _slotsResponse.month = DateTime.now().month;
        List<Dates> dates = [];
        List<Slots> slots = [];
        for (int indexJ = 0; indexJ < timeSlot.length; indexJ++) {
          Slots slot = Slots(
              start: timeSlot[indexJ].start, end: timeSlot[indexJ].start ?? "");
          slots.add(slot);
        }
        _slotsResponse.dates
            .add(Dates(date: int.parse(modelDate), slots: slots));
      }
      // _slotsResponse.dates = dates;
    }

    return _slotsResponse;
  }
}
