// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:fare_now_provider/models/calender_events/timing_dates_data.dart';
import 'package:fare_now_provider/util/app_colors.dart';
import 'package:flutter/material.dart';

class CellContent extends StatelessWidget {
  final day;
  final focusedDay;
  final isTodayHighlighted;
  final isToday;
  final isSelected;
  final isRangeStart;
  final isRangeEnd;
  final isWithinRange;
  final isOutside;
  final isDisabled;
  final isHoliday;
  final isWeekend;
  final calendarStyle;
  final calendarBuilders;
  final timeList;

  const CellContent({
    Key? key,
    this.day,
    this.timeList,
    this.focusedDay,
    this.calendarStyle,
    this.calendarBuilders,
    this.isTodayHighlighted,
    this.isToday,
    this.isSelected,
    this.isRangeStart,
    this.isRangeEnd,
    this.isWithinRange,
    this.isOutside,
    this.isDisabled,
    this.isHoliday,
    this.isWeekend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cell =
        calendarBuilders.prioritizedBuilder?.call(context, day, focusedDay);

    if (cell != null) {
      return cell;
    }

    final text = '${day.day}';
    final margin = calendarStyle.cellMargin;
    final duration = const Duration(milliseconds: 250);

    if (isDisabled) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.disabledDecoration,
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.disabledTextStyle),
          );
    } else if (isSelected) {
      cell = calendarBuilders.selectedBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.selectedDecoration,
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.selectedTextStyle),
          );
    } else if (isRangeStart) {
      cell =
          calendarBuilders.rangeStartBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                decoration: calendarStyle.rangeStartDecoration,
                alignment: Alignment.center,
                child: Text(text, style: calendarStyle.rangeStartTextStyle),
              );
    } else if (isRangeEnd) {
      cell = calendarBuilders.rangeEndBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.rangeEndDecoration,
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.rangeEndTextStyle),
          );
    } else if (isToday && isTodayHighlighted) {
      cell = calendarBuilders.todayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: selectedDate(day),
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.todayTextStyle),
          );
    } else if (isHoliday) {
      cell = calendarBuilders.holidayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.holidayDecoration,
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.holidayTextStyle),
          );
    } else if (isWithinRange) {
      cell =
          calendarBuilders.withinRangeBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                decoration: calendarStyle.withinRangeDecoration,
                alignment: Alignment.center,
                child: Text(text, style: calendarStyle.withinRangeTextStyle),
              );
    } else if (isOutside) {
      cell = calendarBuilders.outsideBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.outsideDecoration,
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.outsideTextStyle),
          );
    } else {
      cell = calendarBuilders.defaultBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: checkDate(day),
            // decoration: isWeekend
            //     ? calendarStyle.weekendDecoration
            //     : calendarStyle.defaultDecoration,
            alignment: Alignment.center,
            child: Text(
              text,
              style: checkTextStyle(day),
              // style: isWeekend
              //     ? calendarStyle.weekendTextStyle
              //     : calendarStyle.defaultTextStyle,
            ),
          );
    }

    return cell;
  }

  checkDate(DateTime day) {
    print("difference ${(DateTime.now().difference(day)).inDays}");
    int days = (DateTime.now().difference(day)).inDays;

    if (days > 0) {
      return BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      );
    }

    bool flag = hasShceduleTime(timeList, day);
    if (flag) {
      return BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.appGreen, width: 2));
    }

    return BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black));
  }

  checkTextStyle(DateTime day) {
    print("difference ${(DateTime.now().difference(day)).inDays}");
    int days = (DateTime.now().difference(day)).inDays;

    if (days > 0) {
      return TextStyle(
        color: Colors.white,
      );
    }

    bool flag = hasShceduleTime(timeList, day);
    if (flag) {
      return TextStyle(color: AppColors.appGreen, fontWeight: FontWeight.bold);
    }

    return TextStyle(
      color: Colors.black,
    );
  }

  selectedDate(DateTime day) {
    print("difference ${(DateTime.now().difference(day)).inDays}");
    int days = (DateTime.now().difference(day)).inDays;
    if (days > 0) {
      return BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      );
    }
    return BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,
    );
  }

  bool hasShceduleTime(List timeList, DateTime day) {
    var sDay = day.day.toString();
    var sMonth = day.month.toString();
    var sYear = day.year.toString();
    for (int index = 0; index < timeList.length; index++) {
      TimingDatesData value = timeList[index];
      var cDay = value.date;
      var cMonth = value.month;
      var cYear = value.year;
      if (cMonth == sMonth && cYear == sYear && cDay == sDay) {
        return true;
      }
    }
    return false;
  }
}
