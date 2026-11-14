import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateUtils {
  static String currentTimeStamp({bool includeNano = false}) {
    DateTime now = DateTime.now();

    if (includeNano) {
      return "${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}${now.millisecondsSinceEpoch}${now.microsecondsSinceEpoch}";
    } else {
      return "${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}";
    }
  }

  static String  getFormattedDateAndDayOfWeek() {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('MMMM dd, yyyy');
    DateFormat dayFormat = DateFormat('EEEE');
    String formattedDate = dateFormat.format(now);
    String dayOfWeek = dayFormat.format(now);
    return '$formattedDate - $dayOfWeek';
  }

  static String getCurrentDateTime({bool isYMD = true}) {
    return getCurrentDate(isYMD: isYMD) + " " + getCurrentTime();
  }

  static String getCurrentDate({bool isYMD = true, DateTime? now = null}) {
    if (now == null) {
      now = DateTime.now();
    }
    return isYMD ? "${now.year}-${now.month > 9 ? now.month : "0${now.month}"}-${now.day > 9 ? now.day : "0${now.day}"}" : "${now.day > 9 ? now.day : "0${now.day}"}-${now.month > 9 ? now.month : "0${now.month}"}-${now.year}";
  }

  static String getCurrentTime({DateTime? now = null}) {
    if (now == null) {
      now = DateTime.now();
    }

    return "${now.hour > 9 ? now.hour : "0${now.hour}"}:${now.minute > 9 ? now.minute : "0${now.minute}"}:${now.second > 9 ? now.second : "0${now.second}"}";
  }

  static String getCurrentTimeWithoutSec({DateTime? now = null}) {
    if (now == null) {
      now = DateTime.now();
    }

    return "${now.hour > 9 ? now.hour : "0${now.hour}"}:${now.minute > 9 ? now.minute : "0${now.minute}"}";
  }

  static String getCurrTimestamp({bool includeMillisecond = true}) {
    DateTime now = DateTime.now();
    return includeMillisecond ? "${now.day}${now.month}${now.year}${now.hour}${now.minute}${now.second}${now.millisecond}" : "${now.day}${now.month}${now.year}${now.hour}${now.minute}${now.second}";
  }

  static String getWeekDay(DateTime dateTime) => dateTime == null ? "" : <String>["MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", "SUNDAY"][dateTime.weekday - 1];

  static String timeToString(TimeOfDay timeOfDay) {
    return timeOfDay == null ? "00:00" : "${timeOfDay.hour}:${timeOfDay.minute}";
  }

  static String formatISOTime(DateTime date) {
    var duration = date.timeZoneOffset;
    if (duration.isNegative) {
      return (date.toIso8601String() + "-${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    } else {
      return (date.toIso8601String() + "+${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    }
  }

  static DateTime? getFormattedDateObj(String dmy, {bool isYMD = false}) {
    // only accept  yyyy/mm/dd or yyyy-mm-dd
    if ("$dmy".isEmpty || "$dmy" == "0000-00-00") {
      return null;
    } else {
      List<String> format = dmy.contains("/") ? dmy.split("/") : dmy.split("-");

      return isYMD ? DateTime(int.parse(format[0]), int.parse(format[1]), int.parse(format[2])) : DateTime(int.parse(format[2]), int.parse(format[1]), int.parse(format[0]));
    }
  }

  static String getFormattedDmyString(DateTime dateTime) => dateTime == null ? "" : getDisplayDate(dateTime, isYMD: false);

  static String getDisplayDate(DateTime dateTime, {bool isYMD = true}) => isYMD ? "${dateTime.year}-${dateTime.month > 9 ? dateTime.month : "0${dateTime.month}"}-${dateTime.day > 9 ? dateTime.day : "0${dateTime.day}"}" : "${dateTime.day > 9 ? dateTime.day : "0${dateTime.day}"}-${dateTime.month > 9 ? dateTime.month : "0${dateTime.month}"}-${dateTime.year}";

  static String getFormattedDate({bool isYMD = true, DateTime? now}) {
    now ??= DateTime.now();
    print("your time is ${now.hour}");
    return isYMD ? "${now.year}-${now.month > 9 ? now.month : "0${now.month}"}-${now.day > 9 ? now.day : "0${now.day}"}" : "${now.day > 9 ? now.day : "0${now.day}"}/${now.month > 9 ? now.month : "0${now.month}"}/${now.year}";
  }

  static String getFormattedDateWithTime({bool isYMD = true, DateTime? now}) {
    now ??= DateTime.now();

    return isYMD ? "${now.year}-${now.month > 9 ? now.month : "0${now.month}"}-${now.day > 9 ? now.day : "0${now.day}"} ${now.hour > 9 ? now.hour : "0${now.hour}"}:${now.minute > 9 ? now.minute : "0${now.minute}"}" : "${now.day > 9 ? now.day : "0${now.day}"}/${now.month > 9 ? now.month : "0${now.month}"}/${now.year}  ${now.hour > 9 ? now.hour : "0${now.hour}"}:${now.minute > 9 ? now.minute : "0${now.minute}"}";
  }

  static String getFormattedDmyHSString(DateTime dateTime, {bool isYMD = false}) => dateTime == null ? "" : getDisplayDate(dateTime, isYMD: isYMD) + " " + timeToString(TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));


  static String getDmyString(String dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return "";
    DateTime dateTime = DateTime.parse(dateTimeString); // Parse the string into DateTime object
    return getdisplayDate(dateTime, isYMD: false); // Format the DateTime object
  }

  static String getdisplayDate(DateTime dateTime, {bool isYMD = true}) =>
      isYMD
          ? "${dateTime.year}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)}"
          : "${_twoDigits(dateTime.day)}-${_twoDigits(dateTime.month)}-${dateTime.year}";

  static String _twoDigits(int n) => n.toString().padLeft(2, '0');


  static String timeFromTimestamp(String timestamp) {
    try {
      DateTime dateTime = DateTime.parse(timestamp);
      DateFormat timeFormat = DateFormat('HH:mm');
      return timeFormat.format(dateTime);
    } catch (e) {
      print('Error parsing timestamp: $e');
      return 'Invalid time';
    }
  }

  /// Calculates the total hours between two timestamps and returns it in 'HH:MM' format.

  static String calculateTotalHours(String? checkInTimeStr, String? checkOutTimeStr) {
    if (checkInTimeStr == null || checkOutTimeStr == null ||
        checkInTimeStr.trim().isEmpty || checkOutTimeStr.trim().isEmpty ||
        checkInTimeStr == '0' || checkOutTimeStr == '0') {
      return '--:--';
    }

    try {
      DateTime checkInTime = DateTime.parse(checkInTimeStr);
      DateTime checkOutTime = DateTime.parse(checkOutTimeStr);

      if (checkOutTime.isBefore(checkInTime)) {
        return '--:--';
      }

      Duration duration = checkOutTime.difference(checkInTime);
      int hours = duration.inHours;
      int minutes = duration.inMinutes % 60;
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    } catch (e) {
      print('Error calculating total hours: $e');
      return '--:--';
    }
  }

}






class FinancialYear {
  DateTime startDate;
  DateTime endDate;

  FinancialYear(this.startDate, this.endDate);
}
