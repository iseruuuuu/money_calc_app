import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:money_calc_app/admob/admob_state.dart';
import 'package:money_calc_app/component/appbar/app_bar_item.dart';
import 'package:money_calc_app/component/bottom_item/bottom_navigation_bar_items.dart';
import 'package:money_calc_app/component/home_screen/floating_action_button_items.dart';
import 'package:money_calc_app/component/home_screen/list_item.dart';
import 'package:money_calc_app/component/home_screen/money_label.dart';
import 'package:money_calc_app/component/home_screen/no_list.dart';
import 'package:money_calc_app/database/todo_bloc.dart';
import 'package:money_calc_app/model/color.dart';
import 'package:money_calc_app/model/todo.dart';
import 'package:money_calc_app/model/notification/date_service.dart';
import 'package:money_calc_app/preference/preference.dart';
import 'package:money_calc_app/screen/add_screen/add_screen.dart';
import 'package:money_calc_app/screen/push_notificaiton_screen/push_notification_screen.dart';
import 'package:money_calc_app/_%E4%BD%BF%E3%82%8F%E3%81%AA%E3%81%84/push_setting/push_setting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:money_calc_app/admob/admob.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:provider/provider.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import 'children/menu_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
    required this.flutterLocalNotificationsPlugin,
  }) : super(key: key);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> todoList = [];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();
  final InAppReview inAppReview = InAppReview.instance;
  String expression = '';
  String expression2 = '';
  Parser parse = Parser();
  Parser parse2 = Parser();
  final preference = Preference();
  bool isFirst = false;
  bool checkUpdate = false;
  int indexes = 0;
  bool isOpened = false;
  final isSex = false;

  @override
  void initState() {
    super.initState();
    getPreference();
    checkPreference();
    WidgetsBinding.instance?.addPostFrameCallback((_) => initPlugin());
  }

  Future<void> initPlugin() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  late BannerAd banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          request: const AdRequest(),
          listener: adState.adListener,
        )..load();
      });
    });
  }

  Future<void> checkPreference() async {
    isFirst = await preference.getBool(PreferenceKey.isDelete);
    checkUpdate = await preference.getBool(PreferenceKey.isUpdateCheck);
    if (todoList.isEmpty) {
      isFirst = true;
    }
    update();
  }

  void update() {
    if (!checkUpdate) {
      dialogs();
      checkUpdate = true;
      preference.setBool(PreferenceKey.isUpdateCheck, true);
    }
  }

  void dialogs() {
    showDialog(
      context: context,
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
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    setState(() {
      setPreference();
      sumMoney();
    });
  }

  Future<void> setPreference() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList('ke', todoList);
    prefs.setString('ke2', expression);
    prefs.setString('ke3', expression2);
  }

  getPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoList = prefs.getStringList('ke') ?? [];
      expression = prefs.getString('ke2') ?? '';
      expression2 = prefs.getString('ke3') ?? '';
    });
  }

  void sumMoney() {
    if (todoList.isNotEmpty) {
      var amount = todoList.join('+');
      ContextModel cm = ContextModel();
      Expression exp = parse.parse(amount);
      double count1 = exp.evaluate(EvaluationType.REAL, cm);
      int b = count1.toInt();
      expression = b.toString();
      var amount2 = todoList.join('+');
      final sum = '1030000-(' + amount2 + ')';
      Expression exp2 = parse2.parse(sum);
      ContextModel cm2 = ContextModel();
      double count2 = exp2.evaluate(EvaluationType.REAL, cm2);
      int b2 = count2.toInt();
      expression2 = b2.toString();
      int.parse(expression2);
    }
  }

  void reset() {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text("更新の確認"),
        content: const Text("給料の記録を2022年版に更新します。"),
        actions: [
          CupertinoDialogAction(
            child: const Text('キャンセル'),
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () async {
              Navigator.of(context).pop();
              isFirst = await preference.getBool(PreferenceKey.isDelete);
              setState(() {
                preference.setBool(PreferenceKey.isDelete, true);
                isFirst = true;
                todoList.clear();
              });
            },
          )
        ],
      ),
    );
  }

  void onTapSetting() {
    Navigator.push(
      context,
      MaterialPageRoute(
        // builder: (context) => PushSettingScreen(
        //   currentMonth: DateService().getCurrentMonthNumber(),
        // ),
        builder: (context) => PushNotificationScreen(
          currentMonth: DateService().getCurrentMonthNumber(),
        ),
      ),
    );
    toggleMenu();
  }

  toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
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
    } else {
      //今はできない。
      print('できないよ');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<TodoBloc>(context, listen: false);
    return SideMenu(
      key: _sideMenuKey,
      type: SideMenuType.slide,
      // background: Colors.orange.shade300,
      menu: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: MenuItem(
          onTapNotification: onTapSetting,
          onTapStar: onTapStar,
        ),
      ),
      onChange: (_isOpened) {
        setState(() {
          isOpened = _isOpened;
        });
      },
      child: Scaffold(
        backgroundColor: AppColor.grey3,
        appBar: (todoList.isNotEmpty)
            ? PreferredSize(
                preferredSize: const Size.fromHeight(35.0),
                child: AppBarItem(
                  color: AppColor.red2,
                  icon: IconButton(
                    //onPressed: onTapSetting,
                    onPressed: toggleMenu,
                    icon: Icon(
                      Icons.menu,
                      size: 30,
                      color: AppColor.white,
                    ),
                  ),
                ),
              )
            : PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: AppBarItem(color: AppColor.grey3)),
        body: (todoList.isNotEmpty)
            ? Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  SafeArea(
                    child: Column(
                      children: [
                        //TODO 次のアプデにする。
                        // SizedBox(
                        //   height: 50,
                        //   child: AdWidget(ad: banner),
                        // ),
                        Container(
                          color: AppColor.red2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, right: 10, left: 10, top: 5),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AppColor.white,
                                  width: 5,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                title: Center(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 10),
                                        child: MoneyLabel(
                                            title: '合計', exp: expression + '円'),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: MoneyLabel(
                                            title: '残り',
                                            exp: expression2 + '円'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Visibility(
                        //     visible: !isFirst, child: ResetButton(onTap: reset)),
                        const SizedBox(height: 10),
                        Expanded(
                          child: StreamBuilder<List<Todo>>(
                            stream: _bloc.todoStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Todo>> snapshot) {
                              if (snapshot.hasData && todoList.isNotEmpty) {
                                return ListView.builder(
                                  itemCount: todoList.length,
                                  itemBuilder: (context, index) {
                                    Todo todo = snapshot.data![index];
                                    indexes = index;
                                    return Dismissible(
                                      key: Key(todoList[index]),
                                      onDismissed: (direction) {
                                        setState(() {
                                          todoList.removeAt(index);
                                        });
                                      },
                                      child: ListItem(
                                        title: '￥' + todoList[index],
                                        day: todo.dueDate.toString(),
                                      ),
                                    );
                                  },
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const SafeArea(child: NoList()),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButtonItems(
          onTap: () async {
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
              setState(() {
                todoList.add(newListText);
              });
            }
          },
        ),
        bottomNavigationBar: const BottomNavigationBarItems(),
      ),
    );
  }
}
