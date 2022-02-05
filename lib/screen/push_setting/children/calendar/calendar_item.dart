import 'package:flutter/material.dart';
import 'package:money_calc_app/notification/date_service.dart';

import 'calendar_day_item.dart';

class CalendarItem extends StatefulWidget {
  final int currentMonth;

  const CalendarItem({
    required Key key,
    required this.currentMonth,
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<CalendarItem> {
  int _amountOfDaysToPresent = 0;

  @override
  void initState() {
    super.initState();
    _amountOfDaysToPresent = DateService().amountOfDaysInMonth(
      DateService().convertMonthToWord(widget.currentMonth),
    );
  }

  @override
  void didUpdateWidget(CalendarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _amountOfDaysToPresent = DateService().amountOfDaysInMonth(
      DateService().convertMonthToWord(widget.currentMonth),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: (MediaQuery.of(context).size.height),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5),
          itemCount: _amountOfDaysToPresent,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return CalendarDay(
              key: Key(widget.currentMonth.toString()),
              date: DateService().constructDateTimeFromDayAndMonth(
                day: (index + 1),
                month: widget.currentMonth,
              ),
            );
          },
        ),
      ),
    );
  }
}
