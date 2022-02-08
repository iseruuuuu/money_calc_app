import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:money_calc_app/admob/admob_state.dart';
import 'package:money_calc_app/database/todo_bloc.dart';
import 'package:money_calc_app/model/todo.dart';
import 'package:money_calc_app/preference/preference.dart';
import 'package:money_calc_app/screen/add_screen/add_screen.dart';
import 'package:money_calc_app/screen/push_notificaiton_screen/push_notification_screen.dart';
import 'package:money_calc_app/screen/setting_screen/setting_screen.dart';
import 'package:provider/provider.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/painting.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreenController extends GetxController {
  List<String> todoList = [];
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

  @override
  void onInit() {
    super.onInit();
    getPreference();
    checkPreference();
    WidgetsBinding.instance?.addPostFrameCallback((_) => initPlugin());
    setMoney();
  }

  Future<void> initPlugin() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  late BannerAd banner;

  Future<void> checkPreference() async {
    isFirst.value = await preference.getBool(PreferenceKey.isDelete);
    checkUpdate.value = await preference.getBool(PreferenceKey.isUpdateCheck);
    if (todoList.isEmpty) {
      isFirst.value = true;
    }
    updateMoney();
  }

  void updateMoney() {
    if (!checkUpdate.value) {
      dialogs();
      checkUpdate.value = true;
      preference.setBool(PreferenceKey.isUpdateCheck, true);
    }
  }

  void onChanged(bool _isOpened) {
    (isOpened) {
      isOpened = _isOpened;
    };
  }

  void dialogs() {
    showDialog(
      context: Get.context!,
      builder: (_) => NetworkGiffDialog(
        image: Image.asset('assets/images/dialog.gif'),
        title: const Text(
          '給料記録の更新を行います',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        description: const Text(
          'あけましておめでとうございます\n'
          '今年も頑張っていきましょう!!\n'
          'by 製作者',
          textAlign: TextAlign.center,
        ),
        entryAnimation: EntryAnimation.bottomLeft,
        onlyCancelButton: false,
        onlyOkButton: true,
        buttonOkColor: Colors.blueAccent,
        onOkButtonPressed: () {
          Get.back();
        },
      ),
    );
  }

  //TODO setMoney
  // @override
  // void setState(VoidCallback fn) {
  //   super.setState(fn);
  //   setState(() {
  //     setPreference();
  //     sumMoney();
  //   });
  // }

  void setMoney() {
    setPreference();
    sumMoney();

    final adState = Provider.of<AdState>(Get.context!);
    adState.initialization.then((status) {
      banner = BannerAd(
        adUnitId: adState.bannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: adState.adListener,
      )..load();
    });
  }

  Future<void> setPreference() async {
    final SharedPreferences prefs = await preferences;
    prefs.setStringList('ke', todoList);
    prefs.setString('ke2', expression.value);
    prefs.setString('ke3', expression2.value);
  }

  getPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    todoList = prefs.getStringList('ke') ?? [];
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
    //TODO 遷移をModalShowDialogにしたい
    final newListText = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return AddScreen(
            todo: Todo.newTodo(),
            todoBloc: _bloc,
          );
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
              //Navigator.of(context).pop();
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
    Get.to(() => const SettingScreen());
    toggleMenu();
  }
}
