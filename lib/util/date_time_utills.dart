import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateTimeUtils {
  DateTime fromTimeStamp(int stamp) {
    return DateTime.fromMicrosecondsSinceEpoch(stamp);
  }

  DateTime convertString(String dateTime) {
    String format = "yyyy-MM-ddTHH:mm";
    if (dateTime.contains("Z")) {
      format = "yyyy-MM-dd HH:mm";
    }
    if (dateTime.contains("T")) {
      dateTime = dateTime.replaceAll("T", " ");
    }

    return DateFormat(format).parse(dateTime);
  }

  DateTime convertStringWoT(String dateTime) {
    if (dateTime.contains("T")) {
      dateTime = dateTime.replaceAll("T", " ");
    }

    return DateFormat("yyyy-MM-dd HH:mm").parse(dateTime);
  }

  DateTime onlyDate(String dateTime) {
    if (dateTime.contains("T")) {
      dateTime = dateTime.replaceAll("T", " ");
    }
    String format = "yyyy-MM-dd";
    if (dateTime.length > 10) {
       format = "yyyy-MM-dd HH:mm";
    }
    var dateTimeUTC = DateFormat(format).parse(dateTime, true);
    if (dateTimeUTC.isUtc) {
      return dateTimeUTC.toLocal();
    }
    return DateFormat("yyyy-MM-dd").parse(dateTime);
  }

  DateTime convertStringSeconds(String? dateTime) {
    dateTime = dateTime ?? DateTime.now().toString();
    if (dateTime.contains("T")) {
      dateTime = dateTime.replaceAll("T", " ");
    }
    var timmes = parseDateTime(
        DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateTime),
        "yyyy-MM-dd hh:mm:ss");

    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(timmes);
  }

  String checkSince(DateTime time) {
    return timeago.format(time.isUtc ? time.toLocal() : time);
  }

  String parseDateTime(DateTime time, String formatExp) {
    final format = DateFormat(formatExp);
    String timeStr = format.format(time);
    return timeStr;
  }

  String getTime(int time) {
    int timeStamp = DateTime.now().microsecondsSinceEpoch;
    String convert = parseDateTime(fromTimeStamp(time), "dd/MM/yyyy hh:mm aa");

    return convert;
  }

  DateTime convertWorkingHoursTime(dateTime) {
    if (dateTime.contains("T")) {
      dateTime = dateTime.replaceAll("T", " ");
    }
    String format = "yyyy-MM-dd";
    if (dateTime.length > 10) {
      format = "yyyy-MM-dd hh:mm:ss";
    }
    var dateTimeUTC = DateFormat(format).parse(dateTime, true);
    String parseDateTim = parseDateTime(dateTimeUTC.toLocal(), "yyyy-MM-dd hh:mm:ss");
    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(parseDateTim);
  }
}
