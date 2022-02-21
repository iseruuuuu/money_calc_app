import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:money_calc_app/database/todo_bloc.dart';
import 'package:money_calc_app/preference/preference.dart';
import 'package:money_calc_app/screen/push_notificaiton_screen/push_notification_screen.dart';
import 'package:money_calc_app/screen/setting_screen/setting_screen.dart';
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
  var isFirst = false.obs;
  var checkUpdate = false.obs;
  var indexes = 0.obs;
  var isOpened = false.obs;
  final isSex = false;

  // final banner = BannerAd(
  //   adUnitId: Platform.isAndroid
  //       ? 'ca-app-pub-3940256099942544/6300978111'
  //       : 'ca-app-pub-3940256099942544/2934735716',
  //   // : 'ca-app-pub-4066682931432506/4038530394',
  //   //本番id
  //   //return 'ca-app-pub-4066682931432506/4038530394';
  //   //テスト広告
  //   // return 'ca-app-pub-3940256099942544/2934735716';
  //   size: AdSize.banner,
  //   request: const AdRequest(),
  //   listener: const AdListener(),
  // ).obs;

  var image = ''.obs;

  //TODO 名前を変更する。
  final name = ''.obs;
  final userName = 'Hello User'.obs;

  void setImage({required String image}) {
    preference.setString(PreferenceKey.image, image);
  }

  @override
  void onInit() {
    super.onInit();
    getPreference();
    checkPreference();
    WidgetsBinding.instance?.addPostFrameCallback((_) => initPlugin());
    //banner.value.load();
    setMoney();
  }

  Future<void> initPlugin() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  Future<void> checkPreference() async {
    isFirst.value = await preference.getBool(PreferenceKey.isDelete);
    checkUpdate.value = await preference.getBool(PreferenceKey.isUpdateCheck);
    image.value = await preference.getString(PreferenceKey.image);
    if (todoList.isEmpty) {
      isFirst.value = true;
    }
    updateMoney();
  }

  void updateMoney() {
    if (!checkUpdate.value) {
      checkUpdate.value = true;
      preference.setBool(PreferenceKey.isUpdateCheck, true);
    }
  }

  void onChanged(bool _isOpened) {
    (isOpened) {
      isOpened = _isOpened;
    };
  }

  void setMoney() {
    setPreference();
    sumMoney();
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
    setMoney();
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
      setMoney();
    }
  }

  void reset() {
    showDialog(
      context: Get.context!,
      builder: (_) => CupertinoAlertDialog(
        title: const Text("更新の確認"),
        content: const Text("給料の記録を2022年版に更新します。"),
        actions: [
          CupertinoDialogAction(
            child: const Text('キャンセル'),
            isDestructiveAction: true,
            onPressed: () {
              // Navigator.of(context).pop();
              Get.back();
            },
          ),
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () async {
              Get.back();
              isFirst.value = await preference.getBool(PreferenceKey.isDelete);
              preference.setBool(PreferenceKey.isDelete, true);
              isFirst.value = true;
              todoList.clear();
              setMoney();
            },
          )
        ],
      ),
    );
  }

  void onTapHome() {
    toggleMenu();
  }

  toggleMenu([bool end = false]) {
    if (end) {
      final _state = endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }

  void onTapStar() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  void onTapNotification() {
    Get.to(() => const PushNotificationScreen());
    toggleMenu();
  }

  void onTapSetting() {
    Get.to(
      () => SettingScreen(
        AdItem: Container(),
      ),
    );
    toggleMenu();
  }

  void onTapChangeName() {
    final deviceWidth = MediaQuery.of(Get.context!).size.width;
    Get.dialog(
      AlertDialog(
        // insetPadding: EdgeInsets.all(deviceWidth / 5),
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
                  // labelText: 'ユーザー名',
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
