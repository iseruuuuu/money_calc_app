import 'package:intl/intl.dart';
import 'package:money_calc_app/constants/constants.dart';

class DateService {
  static final DateService _dateService = DateService._internal();

  factory DateService() {
    return _dateService;
  }

  DateService._internal();

  int getCurrentMonthNumber() {
    DateTime now = DateTime.now();
    return now.month;
  }

  String convertMonthToWord(int month) {
    String? monthName = months[month];
    return monthName ?? "";
  }

  String getCurrentMonthName() {
    return convertMonthToWord(getCurrentMonthNumber());
  }

  int amountOfDaysInMonth(String month) {
    int days = 0;
    switch (month) {
      case "January":
      case "March":
      case "May":
      case "July":
      case "August":
      case "October":
      case "December":
        {
          days = 31;
          break;
        }
      case "April":
      case "June":
      case "September":
      case "November":
        {
          days = 30;
          break;
        }
      case "February":
        {
          days = isLeapYear() ? 29 : 28;
          break;
        }
    }

    return days;
  }

  bool isLeapYear() {
    DateTime now = DateTime.now();
    int year = now.year;
    if (year % 4 == 0 && year % 100 != 0) {
      return true;
    } else if (year % 4 == 0 && year % 100 == 0 && year % 400 == 0) {
      return true;
    }
    return false;
  }

  String getWeekdayNameFromDate(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  DateTime constructDateTimeFromDayAndMonth(
      {required int day, required int month}) {
    int year = DateTime.now().year;
    String paddedMonth = month < 10 ? "0" + month.toString() : month.toString();
    String paddedDay = day < 10 ? "0" + day.toString() : day.toString();
    String wholeDate = year.toString() + "-$paddedMonth-$paddedDay";
    return DateTime.parse(wholeDate);
  }

  String formatDateForSharedPrefs({required DateTime date}) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.format(date);
  }
}
