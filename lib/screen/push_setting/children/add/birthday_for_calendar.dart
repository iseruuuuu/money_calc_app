import 'package:flutter/material.dart';
import 'package:money_calc_app/notification/date_service.dart';
import 'package:money_calc_app/notification/push_notification.dart';
import 'package:money_calc_app/notification/user_birthday.dart';
import 'package:money_calc_app/preference/shared_preferences.dart';
import '../dialog/add_birthday.dart';
import '../birthday.dart';

class BirthdaysForCalendarDayWidget extends StatefulWidget {
  final DateTime dateOfDay;
  final List<UserBirthday> birthdays;

  const BirthdaysForCalendarDayWidget({
    required Key key,
    required this.dateOfDay,
    required this.birthdays,
  }) : super(key: key);

  @override
  _BirthdaysForCalendarDayWidgetState createState() =>
      _BirthdaysForCalendarDayWidgetState();
}

class _BirthdaysForCalendarDayWidgetState
    extends State<BirthdaysForCalendarDayWidget> {
  List<UserBirthday> currentBirthdays = [];
  final _formKey = GlobalKey<FormState>();

  void _handleUserInput(UserBirthday userBirthday) {
    _addBirthdayToList(userBirthday);
    NotificationService().scheduleNotificationForBirthday(
        userBirthday, " has an upcoming birthday!");
  }

  void _addBirthdayToList(UserBirthday userBirthday) {
    setState(() {
      currentBirthdays.add(userBirthday);
    });
    SharedPrefs().setString(widget.dateOfDay, currentBirthdays);
  }

  void _removeBirthdayFromList(UserBirthday birthdayToRemove) {
    setState(() {
      currentBirthdays.remove(birthdayToRemove);
    });
    SharedPrefs().setString(widget.dateOfDay, currentBirthdays);
  }

  @override
  void initState() {
    currentBirthdays = widget.birthdays;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "${widget.dateOfDay.day}日",
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: currentBirthdays.length,
                itemBuilder: (BuildContext context, int index) {
                  return Birthday(
                    //TODo 様子見 ->今は問題がなさそう。
                    key: Key(currentBirthdays[index].birthdayDate.toString()),
                    birthdayOfPerson: currentBirthdays[index],
                    onDeletePressedCallback: () {
                      _removeBirthdayFromList(currentBirthdays[index]);
                    },
                    indexOfBirthday: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await showDialog(
              context: context,
              builder: (_) => AddBirthday(dateOfDay: widget.dateOfDay));
          if (result != null) {
            _handleUserInput(result);
          }
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
