import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:money_calc_app/model/notification/date_service.dart';
import 'package:money_calc_app/model/notification/push_notification.dart';
import 'package:money_calc_app/preference/preference.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PushNotificationScreen extends StatefulWidget {
  const PushNotificationScreen({
    Key? key,
    required this.currentMonth,
  }) : super(key: key);

  final int currentMonth;

  @override
  _PushNotificationScreenState createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  int monthToPresent = -1;
  String month = "";
  int _amountOfDaysToPresent = 0;
  int selectedDays = 0;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    getPreference();
    _amountOfDaysToPresent = DateService().amountOfDaysInMonth(
        DateService().convertMonthToWord(widget.currentMonth));
    monthToPresent = widget.currentMonth;
    month = DateService().convertMonthToWord(monthToPresent);
    NotificationService().init(_onDidReceiveLocalNotification).whenComplete(
          () => NotificationService()
              .handleApplicationWasLaunchedFromNotification(""),
        );
  }

  getPreference() async {
    final pref = await Preference().getInt(PreferenceKey.days);
    setState(() {
      selectedDays = pref;
    });
  }

  @override
  void didUpdateWidget(PushNotificationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _amountOfDaysToPresent = DateService().amountOfDaysInMonth(
      DateService().convertMonthToWord(widget.currentMonth),
    );
  }

  Future<dynamic> _onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    showDialog(
      context: context,
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
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: "毎月$selectedDays日に通知が来ます！",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                //登録した日付を登録する。
                (selectedDays != 0) ? '通知：毎月$selectedDays日' : '未設定',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  height: (MediaQuery.of(context).size.height),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                    itemCount: _amountOfDaysToPresent,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final date =
                          DateService().constructDateTimeFromDayAndMonth(
                        day: (index + 1),
                        month: widget.currentMonth,
                      );
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            selectedDays = date.day;
                          });

                          //選択した日付
                          Preference().setInt(PreferenceKey.days, date.day);

                          //すでに登録されていたら、通知を全て消す。→上書きできていることが確認できた。
                          cancelAll();

                          //通知を出現する
                          scheduleNotification();

                          //pop upみたいに登録できたことを連絡する。
                          popUpDialog();
                        },
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black12,
                                  //TODO 後で色の条件を書く.
                                  //   color: (_birthdays.isNotEmpty)
                                  //       ? Colors.indigo
                                  //       : Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    date.day.toString(),
                                    style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
