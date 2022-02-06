import 'package:flutter/material.dart';
import 'package:money_calc_app/model/notification/push_notification.dart';
import 'package:money_calc_app/model/notification/user_birthday.dart';
import 'package:money_calc_app/preference/shared_preferences.dart';

class Birthday extends StatefulWidget {
  final UserBirthday birthdayOfPerson;
  final VoidCallback onDeletePressedCallback;
  final int indexOfBirthday;

  const Birthday({
    required Key key,
    required this.birthdayOfPerson,
    required this.onDeletePressedCallback,
    required this.indexOfBirthday,
  }) : super(key: key);

  @override
  _BirthdayState createState() => _BirthdayState();
}

class _BirthdayState extends State<Birthday> {
  bool isNotificationEnabledForPerson = false;

  void updateNotificationStatusForBirthday() {
    print('sa');
    setState(() {
      isNotificationEnabledForPerson = !isNotificationEnabledForPerson;
    });
    SharedPrefs().updateNotificationStatusForBirthday(widget.birthdayOfPerson, isNotificationEnabledForPerson);
    if (!isNotificationEnabledForPerson) {
     //NotificationService().cancel(widget.birthdayOfPerson);
      NotificationService().cancel();
    } else {
      NotificationService().scheduleNotification(
          widget.birthdayOfPerson,
          "${widget.birthdayOfPerson.name} has an upcoming birthday!");

    }
  }

  Color _getColorBasedOnPosition(int index, String element) {
    if (element == "background") {
      return index % 2 == 0 ? Colors.indigoAccent : Colors.white24;
    }

    return index % 2 == 0 ? Colors.white : Colors.black;
  }

  @override
  void initState() {
    isNotificationEnabledForPerson = widget.birthdayOfPerson.hasNotification;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: _getColorBasedOnPosition(widget.indexOfBirthday, "background"),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '通知',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: _getColorBasedOnPosition(
                  widget.indexOfBirthday,
                  "text",
                ),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.clear,
              size: 30,
              color: _getColorBasedOnPosition(
                widget.indexOfBirthday,
                "icon",
              ),
            ),
            onPressed: widget.onDeletePressedCallback,
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
