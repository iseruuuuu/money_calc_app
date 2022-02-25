import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:money_calc_app/database/todo_bloc.dart';
import 'package:money_calc_app/preference/shared_preferences.dart';
import 'package:money_calc_app/screen/home_screen/home_screen.dart';
import 'package:money_calc_app/screen/home_screen/home_screen_android.dart';
import 'package:money_calc_app/screen/home_screen/home_screen_idea/home_screen_ios.dart';
import 'package:money_calc_app/screen/home_screen/home_screenss.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constants/typography.dart';

// import 'misc/appInfo.dart' as appInfo;

Future<void> main() async {
  // await appInfo.init();
  // WidgetsFlutterBinding.ensureInitialized();

//TODO 後で戻す！！
// final initFuture = MobileAds.instance.initialize();
// final adState = AdState(initFuture);

// final futureMobileAds = MobileAds.instance.initialize();
// final adSettings = AdSettings(
//     futureMobileAds,
//     testMode: true,
//     //isAmazonApp: kIsAmazonApp
//     );

//TODO 後で戻す！！
  //Admob.initialize();

  //TODO 何に使うかわからないから後でもとす
  //await SharedPrefs().init();

//
// runApp(
//   Provider.value(
//     value: adSettings,
//     builder: (context, child) => const App(),
//   ),
// );

// runApp(
//   Provider.value(
//     value: adState,
//     builder: (context, child) => const App(),
//   ),

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const locale = Locale("ja", "JP");
    final themeData = ThemeData(typography: kTypography);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: themeData,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [locale],
      locale: locale,
      home: Provider<TodoBloc>(
        create: (context) => TodoBloc(),
        // child: HomeScreen(),
        // child: const HomeScreen(),
        child: Platform.isAndroid ? const HomeScreenAndroid() : const HomeScreenIOS(),
        //child: HomeScreenAndroid(),
      ),
    );
  }
}
