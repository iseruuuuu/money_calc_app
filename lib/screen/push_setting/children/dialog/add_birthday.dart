import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_calc_app/notification/user_birthday.dart';
import 'package:money_calc_app/preference/shared_preferences.dart';

class AddBirthday extends StatefulWidget {
  final DateTime dateOfDay;

  const AddBirthday({Key? key, required this.dateOfDay}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddBirthdayState();
  }
}

class AddBirthdayState extends State<AddBirthday> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _birthdayPersonController =
      TextEditingController();
  List<UserBirthday> birthdaysForDate = [];

  @override
  void initState() {
    birthdaysForDate = SharedPrefs().getString(widget.dateOfDay);
    super.initState();
  }

  @override
  dispose() {
    _birthdayPersonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      title: const Text(
        '通知の確認',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.indigo,
        ),
      ),
      content: Form(
        key: _formKey,
        child: const Text(
          '通知を登録してもよろしいですか？',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          style: TextButton.styleFrom(primary: Colors.blue),
          onPressed: () {
            if (_formKey.currentState != null &&
                _formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              UserBirthday userBirthday = UserBirthday(
                name: 'name',
                birthdayDate: widget.dateOfDay,
                hasNotification: false,
              );
              Navigator.pop(context, userBirthday);
            }
          },
          child: const Text(
            'OK',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(primary: Colors.red),
          onPressed: () {
            _birthdayPersonController.clear();
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
