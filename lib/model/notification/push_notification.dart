import 'dart:convert';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:money_calc_app/model/notification/user_birthday.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = "123";

  Future<void> init(
      Future<dynamic> Function(int, String?, String?, String?)?
          onDidReceive) async {
    const AndroidInitializationSettings settingsAndroid =
        AndroidInitializationSettings(('@mipmap/ic_stat_app_icon'));
    final IOSInitializationSettings settingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceive);
    final InitializationSettings settings =
        InitializationSettings(android: settingsAndroid, iOS: settingsIOS);
    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onSelectNotification: selectNotification,
    );
  }

  Future selectNotification(String? payload) async {
    UserBirthday userBirthday = getUserBirthdayFromPayload(payload ?? '');
    cancel();
    //scheduleNotification(userBirthday, "has an upcoming birthday!");
  }

  // void scheduleNotification(
  //     UserBirthday userBirthday, String notificationMessage) async {
  //   final now = DateTime.now();
  //   print(now);
  //
  //   final days = await Preference().getInt(PreferenceKey.days);
  //   print(days);
  //
  //   _wasApplicationLaunchedFromNotification();
  //
  //   for (int i = 0; i < 12; i++) {
  //     //TODO 通知を出す。 →クリア
  //     //TODO 通知を1回の実装で何度も出す →クリア
  //     //TODO 通知を1回の処理で12回読んであげる ->クリア
  //     //TODO 通知をキャンセルできるようにする。 ->クリア？
  //     //TODO 指定した日にちの通知を出す。 -> クリア
  //
  //     //TODO 通知を変更できるようにする。
  //     //TODO 通知の日にちを1回だけにしたい。
  //     //TODO 通知を変更したら、他のものを消す。
  //
  //     int _id = i;
  //     //DateTime _date = DateTime(now.year, now.month + i, now.day, 14, 30, 00);
  //     //TODO dayを指定した日にする。
  //     DateTime _date = DateTime(now.year, now.month + i, days, 10, 00, 00);
  //
  //     print(_date);
  //     const detail = NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         channelId,
  //         applicationName,
  //         playSound: true,
  //       ),
  //       iOS: IOSNotificationDetails(),
  //     );
  //     await flutterLocalNotificationsPlugin.schedule(
  //       _id,
  //       '給料は受け取れましたか？',
  //       '忘れないように登録をおすすめします！',
  //       _date,
  //       detail,
  //     );
  //   }
  // }

  //void cancel(UserBirthday birthday) async {
  void cancel() async {
    //とりあえず、12個の通知を消せる。
    await flutterLocalNotificationsPlugin.cancel(0);
    await flutterLocalNotificationsPlugin.cancel(1);
    await flutterLocalNotificationsPlugin.cancel(2);
    await flutterLocalNotificationsPlugin.cancel(3);
    await flutterLocalNotificationsPlugin.cancel(4);
    await flutterLocalNotificationsPlugin.cancel(5);
    await flutterLocalNotificationsPlugin.cancel(6);
    await flutterLocalNotificationsPlugin.cancel(7);
    await flutterLocalNotificationsPlugin.cancel(8);
    await flutterLocalNotificationsPlugin.cancel(9);
    await flutterLocalNotificationsPlugin.cancel(10);
    await flutterLocalNotificationsPlugin.cancel(11);
    await flutterLocalNotificationsPlugin.cancel(12);
  }

  void cancelAll() async {
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
    //TODO 変なエラーあり
    UserBirthday userBirthday = UserBirthday.fromJson(json);
    return userBirthday;
  }

  // Future<bool> _wasApplicationLaunchedFromNotification() async {
  //   NotificationAppLaunchDetails? notificationAppLaunchDetails =
  //       await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  //   if (notificationAppLaunchDetails != null) {
  //     return notificationAppLaunchDetails.didNotificationLaunchApp;
  //   }
  //   return false;
  // }

  void _rescheduleNotificationFromPayload(String payload) {
    //   //TODO 変なエラーあり
    //   UserBirthday userBirthday = getUserBirthdayFromPayload(payload);
    //   //cancel(userBirthday);
    //   cancel();
    //   scheduleNotification(userBirthday, " has an upcoming birthday!");
    // }
  }
}
