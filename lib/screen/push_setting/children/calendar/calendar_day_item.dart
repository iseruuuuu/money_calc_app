import 'package:flutter/material.dart';
import 'package:money_calc_app/notification/user_birthday.dart';
import 'package:money_calc_app/preference/shared_preferences.dart';
import 'package:money_calc_app/screen/push_setting/children/dialog/add_birthday.dart';

import '../add/birthday_for_calendar.dart';

class CalendarDay extends StatefulWidget {
  final DateTime date;

  const CalendarDay({
    required Key key,
    required this.date,
  }) : super(key: key);

  @override
  _CalendarDayState createState() => _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay> {
  List<UserBirthday> _birthdays = [];

  @override
  void initState() {
    _fetchBirthdaysFromStorage();
    super.initState();
  }

  @override
  void didUpdateWidget(CalendarDay oldWidget) {
    super.didUpdateWidget(oldWidget);
    _fetchBirthdaysFromStorage();
  }

  void _fetchBirthdaysFromStorage() {
    setState(() {
      _birthdays = SharedPrefs().getString(widget.date);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BirthdaysForCalendarDayWidget(
              key: Key(widget.date.toString()),
              dateOfDay: widget.date,
              birthdays: _birthdays,
            ),
          ),
        ).then((value) => _fetchBirthdaysFromStorage());
      },
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (_birthdays.isNotEmpty) ? Colors.indigo : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  widget.date.day.toString(),
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
  }
}
