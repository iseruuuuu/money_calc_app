import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_calc_app/database/todo_bloc.dart';
import 'home_screen.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // Admob.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Provider<TodoBloc>(
        create: (context) => TodoBloc(),
        child: const HomeScreen(),
      ),
    );
  }
}
