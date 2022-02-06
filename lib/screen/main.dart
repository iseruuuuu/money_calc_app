import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:money_calc_app/admob/admob_state.dart';
import 'package:money_calc_app/database/todo_bloc.dart';
import 'package:money_calc_app/preference/shared_preferences.dart';
import 'home_screen.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin notifications =
    FlutterLocalNotificationsPlugin();
NotificationDetails platformChannelSpecifics = const NotificationDetails();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //iOS設定
  const IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  //initializationSettingsのオブジェクト作成
  const InitializationSettings initializationSettings =
      const InitializationSettings(
    iOS: initializationSettingsIOS,
    android: null,
  );

  await notifications.initialize(initializationSettings);
  await SharedPrefs().init();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(
    Provider.value(
      value: adState,
      builder: (context, child) => const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
        child: HomeScreen(
          flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
        ),
      ),
    );
  }
}
