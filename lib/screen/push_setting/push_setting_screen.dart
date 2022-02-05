import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_calc_app/notification/date_service.dart';
import 'package:money_calc_app/notification/push_notification.dart';
import 'children/calendar/calendar_item.dart';

class PushSettingScreen extends StatefulWidget {
  const PushSettingScreen({
    Key? key,
    required this.currentMonth,
  }) : super(key: key);

  final int currentMonth;

  @override
  _PushSettingScreenState createState() => _PushSettingScreenState();
}

class _PushSettingScreenState extends State<PushSettingScreen> {
  int monthToPresent = -1;
  String month = "";

  @override
  void initState() {
    monthToPresent = widget.currentMonth;
    month = DateService().convertMonthToWord(monthToPresent);
    NotificationService().init(_onDidReceiveLocalNotification).whenComplete(
          () => NotificationService()
              .handleApplicationWasLaunchedFromNotification(""),
        );
    super.initState();
  }

  int _correctMonthOverflow(int month) {
    if (month == 0) {
      month = 12;
    } else if (month == 13) {
      month = 1;
    }
    return month;
  }

  void _calculateNextMonthToShow(AxisDirection direction) {
    setState(() {
      monthToPresent = direction == AxisDirection.left
          ? monthToPresent + 1
          : monthToPresent - 1;
      monthToPresent = _correctMonthOverflow(monthToPresent);
      month = DateService().convertMonthToWord(monthToPresent);
    });
  }

  void _decideOnNextMonthToShow(DragUpdateDetails details) {
    details.delta.dx > 0
        ? _calculateNextMonthToShow(AxisDirection.right)
        : _calculateNextMonthToShow(AxisDirection.left);
  }

  Future<dynamic> _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title ?? ''),
        content: Text(body ?? ''),
        actions: [
          TextButton(
            child: const Text("Ok"),
            onPressed: () async {
              NotificationService()
                  .handleApplicationWasLaunchedFromNotification(payload ?? '');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知の設定'),
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: _decideOnNextMonthToShow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 5,
              child: CalendarItem(
                key: Key(monthToPresent.toString()),
                currentMonth: monthToPresent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
