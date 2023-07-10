import 'package:date_format/date_format.dart';

class FormateDateTime {
  static String d2sWithHM({required DateTime dateTime}) {
    return formatDate(dateTime, [d, " ", M, " ", hh, ":", nn, " ", am]);
  }

  static String d2sWithoutHM({required DateTime dateTime}) {
    return formatDate(dateTime, [d, " ", M]);
  }

  static String getMonthNameFromDateTime({required DateTime dateTime}) {
    return formatDate(dateTime, [MM]);
  }

  static String getMonthNameFromMonthIndex({required int monthIndex}) {
    
    return formatDate(DateTime(DateTime.now().year,monthIndex), [MM]);
  }
}
