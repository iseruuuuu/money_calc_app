import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:money_calc_app/component/app_bar_item.dart';
import 'package:money_calc_app/component/bottom_navigation_bar_items.dart';
import 'package:money_calc_app/component/floating_action_button_items.dart';
import 'package:money_calc_app/component/list_item.dart';
import 'package:money_calc_app/component/money_label.dart';
import 'package:money_calc_app/component/no_list.dart';
import 'package:money_calc_app/component/reset_button.dart';
import 'package:money_calc_app/model/color.dart';
import 'package:money_calc_app/preference/preference.dart';
import 'package:money_calc_app/screen/add_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:money_calc_app/model/admob.dart';
import 'package:admob_flutter/admob_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> todoList = [];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String amount = '';
  String amount2 = '';
  String expression = '';
  String expression2 = '';
  Parser parse = Parser();
  Parser parse2 = Parser();
  final preference = Preference();
  bool isFirst = false;

  @override
  void initState() {
    super.initState();
    getPreferenceList();
    getPreferenceString();

    checkPreference();
  }

  Future<void> checkPreference() async {
    isFirst = await preference.getBool(PreferenceKey.isDelete);
    if (todoList.isEmpty) {
      isFirst = true;
      print(isFirst);
    }
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    setState(() {
      setPreferenceList();
      setPreferenceString();
      sumMoney();
    });
  }

  Future<void> setPreferenceList() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList('key', todoList);
  }

  getPreferenceList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoList = prefs.getStringList('key') ?? [];
    });
  }

  Future<void> setPreferenceString() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('key2', expression);
    prefs.setString('key3', expression2);
  }

  getPreferenceString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      expression = prefs.getString('key2') ?? '';
      expression2 = prefs.getString('key3') ?? '';
    });
  }

  void sumMoney() {
    if (todoList.isNotEmpty) {
      amount = todoList.join('+');
      ContextModel cm = ContextModel();
      Expression exp = parse.parse(amount);
      double count1 = exp.evaluate(EvaluationType.REAL, cm);
      int b = count1.toInt();
      expression = b.toString();
      amount2 = todoList.join('+');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey3,
      appBar: (todoList.isNotEmpty)
          ? PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: AppBarItem(color: AppColor.red2))
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
                      AdmobBanner(
                        adUnitId: AdMob().getBannerAdUnitId(),
                        adSize: AdmobBannerSize(
                          width: MediaQuery.of(context).size.width.toInt(),
                          height: AdMob().getHeight(context).toInt(),
                          name: 'SMART_BANNER',
                        ),
                      ),
                      Container(
                        color: AppColor.red2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                                          title: '残り', exp: expression2 + '円'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // (isFirst) ? Container() : ResetButton(onTap: reset),
                      Visibility(
                          visible: !isFirst, child: ResetButton(onTap: reset)),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: todoList.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(todoList[index]),
                              onDismissed: (direction) {
                                setState(() {
                                  todoList.removeAt(index);
                                });
                              },
                              child: ListItem(title: '￥' + todoList[index]),
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
      floatingActionButton: FloatingActionButtonItems(onTap: () async {
        //TODO 遷移をModalShowDialogにしたい
        final newListText = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return const AddScreen();
            },
            fullscreenDialog: true,
          ),
        );
        if (newListText != null) {
          setState(() {
            todoList.add(newListText);
          });
        }
      }),
      bottomNavigationBar: const BottomNavigationBarItems(),
    );
  }
}
