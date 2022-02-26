import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:money_calc_app/database/todo_bloc.dart';
import 'package:money_calc_app/preference/preference.dart';
import 'package:money_calc_app/screen/push_notificaiton_screen/push_notification_screen_idea/push_notification_screen.dart';
import 'package:money_calc_app/screen/setting_screen/setting_idea/setting_screen.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:money_calc_app/screen/add_screen/add_screen.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/painting.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreenController extends GetxController {
  RxList<String> todoList = RxList<String>();
  final Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> endSideMenuKey = GlobalKey<SideMenuState>();
  final InAppReview inAppReview = InAppReview.instance;
  Parser parse = Parser();
  Parser parse2 = Parser();
  final preference = Preference();
  var expression = ''.obs;
  var expression2 = ''.obs;
  var indexes = 0.obs;
  var isSex = false.obs;
  final name = ''.obs;
  final userName = 'Hello User'.obs;

  @override
  void onInit() {
    super.onInit();
    getPreference();
    sumMoney();
    WidgetsBinding.instance?.addPostFrameCallback((_) => initPlugin());
  }

  Future<void> initPlugin() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  Future<void> setPreference() async {
    final SharedPreferences prefs = await preferences;
    prefs.setStringList('ke', todoList);
    prefs.setString('ke2', expression.value);
    prefs.setString('ke3', expression2.value);
  }

  getPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    todoList.value = prefs.getStringList('ke') ?? [];
    expression.value = prefs.getString('ke2') ?? '';
    expression2.value = prefs.getString('ke3') ?? '';
    isSex.value = prefs.getBool(PreferenceKey.isSex.toString()) ?? false;
  }

  void sumMoney() {
    if (todoList.isNotEmpty) {
      var amount = todoList.join('+');
      ContextModel cm = ContextModel();
      Expression exp = parse.parse(amount);
      double count1 = exp.evaluate(EvaluationType.REAL, cm);
      int b = count1.toInt();
      expression.value = b.toString();
      var amount2 = todoList.join('+');
      final sum = '1030000-(' + amount2 + ')';
      Expression exp2 = parse2.parse(sum);
      ContextModel cm2 = ContextModel();
      double count2 = exp2.evaluate(EvaluationType.REAL, cm2);
      int b2 = count2.toInt();
      expression2.value = b2.toString();
      int.parse(expression2.value);
    }
  }

  void removeMoney(int index) {
    todoList.removeAt(index);
    setPreference();
    sumMoney();
    setPreference();
  }

  void onTapAddMoney(BuildContext context, TodoBloc _bloc) async {
    final newListText = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const AddScreen();
        },
        fullscreenDialog: true,
      ),
    );
    if (newListText != null) {
      todoList.add(newListText);
      sumMoney();
      setPreference();
    }
  }

  void onTapStar() async {
    if (await inAppReview.isAvailable()) {
      //TODO ローディングを入れたい！
      inAppReview.requestReview();
    }
  }

  void onTapNotification() {
    Get.to(() => const PushNotificationScreens());
  }

  void onTapSetting() {
    Get.to(() => const SettingScreens());
  }

  void onTapChangeName() {
    final deviceWidth = MediaQuery.of(Get.context!).size.width;
    Get.dialog(
      AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        title: SizedBox(
          width: deviceWidth / 1.5,
          height: deviceWidth / 9,
          child: Center(
            child: Text(
              '名前の変更',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: deviceWidth / 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
        content: SizedBox(
          width: deviceWidth / 1.5,
          height: deviceWidth / 6,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: deviceWidth / 20,
                  ),
                  border: const OutlineInputBorder(),
                  label: const Center(child: Text('ユーザー名')),
                  labelStyle: TextStyle(
                    fontSize: deviceWidth / 20,
                  ),
                ),
                onChanged: (text) => onChangeName(text: text),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          SizedBox(
            height: deviceWidth / 7,
            child: TextButton(
              child: Text(
                "Close",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: deviceWidth / 20,
                  color: Colors.red,
                ),
              ),
              onPressed: () => Get.back(),
            ),
          ),
          SizedBox(
            height: deviceWidth / 7,
            child: TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: deviceWidth / 20,
                  color: Colors.indigo,
                ),
              ),
              onPressed: () => onSubmit(),
            ),
          ),
        ],
      ),
    );
  }

  void onChangeName({required String text}) {
    name.value = text;
  }

  void onSubmit() {
    userName.value = name.value;
    Get.back();
  }
}
