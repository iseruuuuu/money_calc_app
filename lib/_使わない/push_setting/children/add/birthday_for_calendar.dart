import 'package:flutter/material.dart';
import 'package:money_calc_app/component/push_notification/add_birthday.dart';
import 'package:money_calc_app/model/notification/push_notification.dart';
import 'package:money_calc_app/model/notification/user_birthday.dart';
import 'package:money_calc_app/preference/shared_preferences.dart';
import 'package:money_calc_app/_%E4%BD%BF%E3%82%8F%E3%81%AA%E3%81%84/push_setting/children/birthday.dart';

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
    NotificationService()
        .scheduleNotification(userBirthday, " has an upcoming birthday!");
  }

  void _addBirthdayToList(UserBirthday userBirthday) {
    setState(() {
      currentBirthdays.add(userBirthday);
    });
    SharedPrefs().setString(widget.dateOfDay, currentBirthdays);
  }

  void remove(UserBirthday birthdayToRemove) {
    setState(() {
      currentBirthdays.remove(birthdayToRemove);
    });
    SharedPrefs().setString(widget.dateOfDay, currentBirthdays);
    print('削除しました');
    //TODO 通知も消せるようにする、
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
                  key: Key(currentBirthdays[index].birthdayDate.toString()),
                    birthdayOfPerson: currentBirthdays[index],
                    onDeletePressedCallback: () {
                      remove(currentBirthdays[index]);
                      //TODO 通知を消す処理を追加する。
                      NotificationService().cancel();
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
              builder: (_) => NotificationDialog(dateOfDay: widget.dateOfDay));
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
