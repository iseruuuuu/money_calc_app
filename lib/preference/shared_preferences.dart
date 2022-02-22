// import 'dart:async';
// import 'dart:convert';
//
// import 'package:money_calc_app/model/notification/date_service.dart';
// import 'package:money_calc_app/model/notification/user_birthday.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPrefs {
//   static SharedPreferences? _sharedPreferences;
//
//   factory SharedPrefs() => SharedPrefs._internal();
//
//   SharedPrefs._internal();
//
//   Future<void> init() async {
//     _sharedPreferences ??= await SharedPreferences.getInstance();
//   }
//
//   List<UserBirthday> getString(DateTime date) {
//     String? birthdaysForDate = _sharedPreferences!
//         .getString(DateService().formatDateForSharedPrefs(date: date));
//     if (birthdaysForDate == null) {
//       return [];
//     }
//     List decodedBirthdaysForDate = jsonDecode(birthdaysForDate);
//     List<UserBirthday> birthdays = decodedBirthdaysForDate
//         .map((decodedBirthday) => UserBirthday.fromJson(decodedBirthday))
//         .toList();
//     return birthdays;
//   }
//
//   void setString(DateTime date, List<UserBirthday> birthdays) {
//     String encoded = jsonEncode(birthdays);
//     _sharedPreferences!
//         .setString(DateService().formatDateForSharedPrefs(date: date), encoded);
//   }
//
//   void updateNotificationStatusForBirthday(
//       UserBirthday birthday, bool updatedStatus) {
//     List<UserBirthday> birthdays = getString(birthday.birthdayDate);
//     for (int i = 0; i < birthdays.length; i++) {
//       UserBirthday savedBirthday = birthdays[i];
//       if (savedBirthday.equals(birthday)) {
//         savedBirthday.updateNotificationStatus(updatedStatus);
//       }
//     }
//     setString(birthday.birthdayDate, birthdays);
//   }
//
//   Future<bool> clearAllNotifications() async {
//     return await _sharedPreferences!.clear();
//   }
// }
