import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:money_calc_app/model/notification/date_service.dart';
import 'package:money_calc_app/model/notification/push_notification.dart';
import 'package:money_calc_app/preference/preference.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PushNotificationScreenController extends GetxController {
  int monthToPresent = -1;
  String month = "";
  int amountOfDaysToPresent = 0;
  var selectedDays = 0.obs;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final int currentMonth = DateService().getCurrentMonthNumber();

  @override
  void onInit() {
    super.onInit();
    getPreference();
    getMonth();
  }

  void getMonth() {
    amountOfDaysToPresent = DateService()
        .amountOfDaysInMonth(DateService().convertMonthToWord(currentMonth));
    monthToPresent = currentMonth;
    month = DateService().convertMonthToWord(monthToPresent);
    NotificationService().init(_onDidReceiveLocalNotification).whenComplete(
          () => NotificationService()
              .handleApplicationWasLaunchedFromNotification(""),
        );
  }

  void onTap(DateTime date) {
      selectedDays.value = date.day;

    //選択した日付
    Preference().setInt(PreferenceKey.days, date.day);

    //すでに登録されていたら、通知を全て消す。→上書きできていることが確認できた。
    cancelAll();

    //通知を出現する
    scheduleNotification();

    //TODO pop upみたいに登録できたことを連絡する。
    //popUpDialog();
  }

  getPreference() async {
    final pref = await Preference().getInt(PreferenceKey.days);
    selectedDays.value = pref;
  }

  // @override
  // void didUpdateWidget(PushNotificationScreen oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   _amountOfDaysToPresent = DateService().amountOfDaysInMonth(
  //     DateService().convertMonthToWord(widget.currentMonth),
  //   );
  // }

  Future<dynamic> _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('給料は受け取れましたか？'),
        content: const Text('忘れないように登録をおすすめします！'),
        actions: [
          TextButton(
            child: const Text("Ok"),
            onPressed: () {
              NotificationService()
                  .handleApplicationWasLaunchedFromNotification(payload ?? '');
            },
          ),
        ],
      ),
    );
  }

  Future<void> scheduleNotification() async {
    final now = DateTime.now();
    final days = await Preference().getInt(PreferenceKey.days);
    for (int i = 0; i < 12; i++) {
      int _id = i;
      //DateTime _date = DateTime(now.year, now.month, now.day, 16, 51 + i, 20);
      DateTime _date = DateTime(now.year, now.month + i, days, 10, 00, 00);
      const detail = NotificationDetails(
        android: AndroidNotificationDetails('id', 'name'),
        iOS: IOSNotificationDetails(),
      );
      await flutterLocalNotificationsPlugin.schedule(
        _id,
        '給料は受け取れましたか？',
        '忘れないように登録をおすすめします！',
        _date,
        detail,
      );
    }
  }

  void cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void popUpDialog() {
  }
  //   showTopSnackBar(
  //     Get.context!,
  //     CustomSnackBar.success(
  //       message: "毎月$selectedDays日に通知が来ます！",
  //     ),
  //   );
  // }
}
