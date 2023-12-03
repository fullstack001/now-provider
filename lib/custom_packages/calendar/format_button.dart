// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:fare_now_provider/custom_packages/calendar/shared/utils.dart'
    show CalendarFormat;
import 'package:flutter/material.dart';

class FormatButton extends StatelessWidget {
  final calendarFormat;
  final onTap;
  final textStyle;
  final decoration;
  final padding;
  final showsNextFormat;
  final availableCalendarFormats;

  const FormatButton({
    Key? key,
    this.calendarFormat,
    this.onTap,
    this.textStyle,
    this.decoration,
    this.padding,
    this.showsNextFormat,
    this.availableCalendarFormats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(_nextFormat()),
      child: Container(
        decoration: decoration,
        padding: padding,
        child: Text(
          _formatButtonText,
          style: textStyle,
        ),
      ),
    );
  }

  String get _formatButtonText => showsNextFormat
      ? availableCalendarFormats[_nextFormat()]
      : availableCalendarFormats[calendarFormat];

  CalendarFormat _nextFormat() {
    final formats = availableCalendarFormats.keys.toList();
    int id = formats.indexOf(calendarFormat);
    id = int.parse(((id + 1) % formats.length).toString());

    return formats[id];
  }
}
