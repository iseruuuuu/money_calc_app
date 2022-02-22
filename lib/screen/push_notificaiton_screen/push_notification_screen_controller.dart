import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:money_calc_app/model/notification/date_service.dart';
import 'package:money_calc_app/model/notification/push_notification.dart';
import 'package:money_calc_app/preference/preference.dart';

class PushNotificationScreenController extends GetxController {
  int monthToPresent = -1;
  String month = "";
  int amountOfDaysToPresent = 0;
  var selectedDays = 0.obs;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final int currentMonth = DateService().getCurrentMonthNumber();
  var day = ''.obs;
  var isCheck = false.obs;
  var days = 0.obs;

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

  getPreference() async {
    final preference = await Preference().getInt(PreferenceKey.days);
    days.value = preference;
  }

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
      //DateTime _date = DateTime(now.year, now.month, now.day, 9, 26 + i, 00);
      DateTime _date = DateTime(now.year, now.month + i, days, 10, 00, 00);
      const detail = NotificationDetails(
        android: AndroidNotificationDetails(
          'id',
          'name',
          playSound: true,
          importance: Importance.max,
          priority: Priority.high,
        ),
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

  void numClick(String text) {
    if (day.value.length > 1) {
    } else {
      day.value += text;
    }
  }

  void onTapDelete() {
    if (day.isNotEmpty) {
      final pos = day.value.length - 1;
      day.value = day.value.substring(0, pos);
    }
  }

  void onTapSubmit() {
    checkNumber();
    if (isCheck.value) {
      //選択した日付
      final checkNumber = int.parse(day.value);
      Preference().setInt(PreferenceKey.days, checkNumber);
      //すでに登録されていたら、通知を全て消す。→上書きできていることが確認できた。
      cancelAll();
      //通知を出現する
      scheduleNotification();
      //ダイアログを出現する
      openDialog(isSuccess: true);
    }
    isCheck.value = false;
  }

  void checkNumber() {
    final checkNumber = int.parse(day.value);
    if (checkNumber > 32) {
      isCheck.value = false;
      openDialog(isSuccess: false);
    } else {
      isCheck.value = true;
    }
  }

  void openDialog({required bool isSuccess}) {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        isSuccess ? '通知登録完了' : '通知登録失敗',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        isSuccess ? '毎月${day.value}日に通知が来るようになりました' : '正しい日程を入力をしてください',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      colorText: Colors.black,
      icon: const Icon(
        Icons.person,
        color: Colors.white,
        size: 40,
      ),
      backgroundColor: isSuccess ? Colors.blue : Colors.red,
      snackPosition: SnackPosition.TOP,
    );
  }
}
