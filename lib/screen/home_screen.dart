import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:money_calc_app/component/app_bar_item.dart';
import 'package:money_calc_app/component/bottom_navigation_bar_items.dart';
import 'package:money_calc_app/component/floating_action_button_items.dart';
import 'package:money_calc_app/component/list_item.dart';
import 'package:money_calc_app/component/money_label.dart';
import 'package:money_calc_app/component/no_list.dart';
import 'package:money_calc_app/model/color.dart';
import 'package:money_calc_app/screen/add_money.dart';
import 'package:money_calc_app/screen/loading_view/overlay_loading_molecules.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:money_calc_app/model/admob.dart';
import 'package:admob_flutter/admob_flutter.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<String> todoList = [];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int count = 0;
  String amount = '';
  String amount2 = '';
  String _exp = '';
  String _exp2 = '';
  String amount3 = '';
  String amount4 = '';
  Parser p = Parser();
  Parser p2 = Parser();
  bool visibleLoading = false;

  @override
  void initState() {
    super.initState();
    //TODO 読み込む間に、Loading画面を入れたい。
    getPreferenceList();
    getPreferenceString();
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
    prefs.setString('key2', _exp);
    prefs.setString('key3', _exp2);
  }

  getPreferenceString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _exp = prefs.getString('key2') ?? '';
      _exp2 = prefs.getString('key3') ?? '';
    });
  }

  void sumMoney() {
    amount = todoList.join('+');
    ContextModel cm = ContextModel();
    Expression exp = p.parse(amount);
    double count1 = exp.evaluate(EvaluationType.REAL, cm);
    int b = count1.toInt();
    _exp = b.toString();
    amount2 = todoList.join('+');
    final sum = '1030000-(' + amount2 + ')';
    Expression exp2 = p2.parse(sum);
    ContextModel cm2 = ContextModel();
    double count2 = exp2.evaluate(EvaluationType.REAL, cm2);
    int b2 = count2.toInt();
    _exp2 = b2.toString();
    int.parse(_exp2);
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
              child: AppBarItem(color: AppColor.white)),
      body: (todoList.isNotEmpty)
          ? Stack(
              fit: StackFit.expand,
              children: <Widget>[
                SafeArea(
                  child: Column(
                    children: [
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
                                          title: '合計', exp: _exp + '円'),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: MoneyLabel(
                                          title: '残り', exp: _exp2 + '円'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                OverlayLoadingMolecules(visible: visibleLoading),
              ],
            )
          : const SafeArea(child: NoList()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonItems(
        onTap: () async {
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const TodoAddPage();
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
    );
  }
}
