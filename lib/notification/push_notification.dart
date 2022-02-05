//TODO

//IOS　Androidを追加する。

//毎月25日に通知を出す

//お疲れ様です!
//お給料が入ったら、登録をしましょう！

//もし　25日が休日だったら、ずらす。

//

//できたら、通知をする日にちを設定できるようにする。

//TODO 通知がしっかり来るかどうか確認する

//TODO 通知の内容を変更する（通知の内容）

//TODO 毎月、指定した日付に通知が来るようにする。

import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:money_calc_app/constants/constants.dart';
import 'package:money_calc_app/notification/user_birthday.dart';
import 'dart:io' show Platform;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channel_id = "123";

  Future<void> init(
      Future<dynamic> Function(int, String?, String?, String?)?
          onDidReceive) async {
    const AndroidInitializationSettings settingsAndroid =
        AndroidInitializationSettings(('app_icon'));

    final IOSInitializationSettings settingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceive);

    final InitializationSettings settings =
        InitializationSettings(android: settingsAndroid, iOS: settingsIOS);

    await flutterLocalNotificationsPlugin.initialize(settings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    UserBirthday userBirthday = getUserBirthdayFromPayload(payload ?? '');
    cancelNotificationForBirthday(userBirthday);
    scheduleNotificationForBirthday(userBirthday, "has an upcoming birthday!");
  }

  void showNotification(
      UserBirthday userBirthday, String notificationMessage) async {
    await flutterLocalNotificationsPlugin.show(
        userBirthday.hashCode,
        applicationName,
        notificationMessage,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            channel_id,
            applicationName,
            // 'To remind you about upcoming birthdays,',
          ),
        ),
        payload: jsonEncode(userBirthday));
  }

  void scheduleNotificationForBirthday(
      UserBirthday userBirthday, String notificationMessage) async {
    DateTime now = DateTime.now();
    DateTime birthdayDate = userBirthday.birthdayDate;
    Duration difference = now.isAfter(birthdayDate)
        ? now.difference(birthdayDate)
        : birthdayDate.difference(now);

    _wasApplicationLaunchedFromNotification().then(
      (bool didApplicationLaunchFromNotification) => {
        if (didApplicationLaunchFromNotification && difference.inDays == 0)
          {
            scheduleNotificationForNextYear(
              userBirthday,
              notificationMessage,
            )
          }
        else if (!didApplicationLaunchFromNotification &&
            difference.inDays == 0)
          {showNotification(userBirthday, notificationMessage)}
      },
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      userBirthday.hashCode,
      applicationName,
      notificationMessage,
      tz.TZDateTime.now(tz.local).add(difference),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          channel_id,
          applicationName,
          //'To remind you about upcoming birthdays',
        ),
      ),
      payload: jsonEncode(userBirthday),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void scheduleNotificationForNextYear(
      UserBirthday userBirthday, String notificationMessage) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        userBirthday.hashCode,
        applicationName,
        notificationMessage,
        tz.TZDateTime.now(tz.local).add(const Duration(days: 365)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            channel_id,
            applicationName,
            //'To remind you about upcoming birthdays',
          ),
        ),
        payload: jsonEncode(userBirthday),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  void cancelNotificationForBirthday(UserBirthday birthday) async {
    await flutterLocalNotificationsPlugin.cancel(birthday.hashCode);
  }

  void cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void handleApplicationWasLaunchedFromNotification(String payload) async {
    if (Platform.isIOS) {
      _rescheduleNotificationFromPayload(payload);
      return;
    }

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.didNotificationLaunchApp) {
      _rescheduleNotificationFromPayload(
          notificationAppLaunchDetails.payload ?? "");
    }
  }

  UserBirthday getUserBirthdayFromPayload(String payload) {
    Map<String, dynamic> json = jsonDecode(payload);
    UserBirthday userBirthday = UserBirthday.fromJson(json);
    return userBirthday;
  }

  Future<bool> _wasApplicationLaunchedFromNotification() async {
    NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails != null) {
      return notificationAppLaunchDetails.didNotificationLaunchApp;
    }

    return false;
  }

  void _rescheduleNotificationFromPayload(String payload) {
    UserBirthday userBirthday = getUserBirthdayFromPayload(payload);
    cancelNotificationForBirthday(userBirthday);
    scheduleNotificationForBirthday(userBirthday, " has an upcoming birthday!");
  }
}
