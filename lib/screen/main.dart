import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:money_calc_app/screen/password_screen/password_screen.dart';
import 'package:money_calc_app/screen/register_screen/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_expressions/math_expressions.dart';
import 'add_money.dart';
import '../model/color.dart';
import 'home_screen/home_screen.dart';
import 'loading_view/overlay_loading_molecules.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: PasswordScreen(),
      // home: TodoListPage(),
      home: RegisterScreen(),
    );
  }
}

