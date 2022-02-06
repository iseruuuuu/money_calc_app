import 'package:money_calc_app/constants/constants.dart';

class UserBirthday {
  final String name;
  final DateTime birthdayDate;
  bool hasNotification;

  UserBirthday({
    required this.name,
    required this.birthdayDate,
    required this.hasNotification,
  });

  void updateNotificationStatus(bool status) {
    hasNotification = status;
  }

  bool equals(UserBirthday otherBirthday) {
    return (name == otherBirthday.name &&
        birthdayDate == otherBirthday.birthdayDate);
  }

  UserBirthday.fromJson(Map<String, dynamic> json)
      : name = json[userBirthdayNameKey],
        birthdayDate =
            DateTime.tryParse(json[userBirthdayDateKey]) ?? DateTime.now(),
        hasNotification = json[userBirthdayHasNotificationKey];

  Map<String, dynamic> toJson() => {
        userBirthdayNameKey: name,
        userBirthdayDateKey: birthdayDate.toIso8601String(),
        userBirthdayHasNotificationKey: hasNotification,
      };
}
