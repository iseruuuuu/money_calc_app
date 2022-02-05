import 'package:flutter/material.dart';
import 'package:money_calc_app/notification/push_notification.dart';
import 'package:money_calc_app/notification/user_birthday.dart';
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
    setState(() {
      isNotificationEnabledForPerson = !isNotificationEnabledForPerson;
    });
    SharedPrefs().updateNotificationStatusForBirthday(
        widget.birthdayOfPerson, isNotificationEnabledForPerson);
    if (!isNotificationEnabledForPerson) {
      NotificationService()
          .cancelNotificationForBirthday(widget.birthdayOfPerson);
    } else {
      NotificationService().scheduleNotificationForBirthday(
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 20),
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
              isNotificationEnabledForPerson
                  ? Icons.notifications_off_outlined
                  : Icons.notifications_active_outlined,
              color: _getColorBasedOnPosition(
                widget.indexOfBirthday,
                "icon",
              ),
            ),
            onPressed: () {
              updateNotificationStatusForBirthday();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.call,
              color: _getColorBasedOnPosition(
                widget.indexOfBirthday,
                "icon",
              ),
            ),
            //onPressed: _handleCallButtonPressed),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.clear,
              color: _getColorBasedOnPosition(
                widget.indexOfBirthday,
                "icon",
              ),
            ),
            onPressed: widget.onDeletePressedCallback,
          ),
        ],
      ),
    );
  }
}
