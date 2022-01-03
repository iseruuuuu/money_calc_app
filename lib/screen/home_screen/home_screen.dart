import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:money_calc_app/component/bottom_navigation_bar_items.dart';
import 'package:money_calc_app/component/floating_action_button_items.dart';
import 'package:money_calc_app/model/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:money_calc_app/model/admob.dart';
import 'package:admob_flutter/admob_flutter.dart';
import '../add_money.dart';
import '../loading_view/overlay_loading_molecules.dart';

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

  bool visibleLoading = false;

  //admob
  //List<BannerAd> bannerAds = [];

  @override
  void initState() {
    super.initState();
    //TODO 読み込む間に、Loading画面を入れたい。
    // loading();
    // loading2();
    getPreferenceList();
    getPreferenceString();
  }

  Future<void> loading() async {
    // setState(() {
    //   visibleLoading = true;
    // });
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    setState(() {
      visibleLoading = false;
    });
  }

  Future<void> loading2() async {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 250),
      // ダイアログフェードインmsec
      barrierColor: Colors.black.withOpacity(0.5),
      // 画面マスクの透明度
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
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
    //TODO １桁の場合は、０１とかになる。
    amount = todoList.join('+');
    Parser p = Parser();
    ContextModel cm = ContextModel();
    Expression exp = p.parse(amount);

    double count1 = exp.evaluate(EvaluationType.REAL, cm);
    int b = count1.toInt();
    _exp = b.toString();

    amount2 = todoList.join('+');
    final sum = '1030000-(' + amount2 + ')';
    Parser p2 = Parser();
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
              child: AppBar(
                backgroundColor: AppColor.red2,
                elevation: 0,
              ),
            )
          : PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: AppBar(
                backgroundColor: AppColor.white,
                elevation: 0,
              ),
            ),
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
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          '合計',
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          _exp + '円',
                                          style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          '残り',
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          _exp2 + '円',
                                          style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
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
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 5, right: 30, left: 30),
                                child: Card(
                                  color: AppColor.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: AppColor.grey3,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Center(
                                      child: Text(
                                        '￥' + todoList[index],
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    child: Image.asset('assets/images/3.png'),
                  ),
                  const SizedBox(height: 30),
                  const Center(
                    child: Text(
                      '給料の記録がありません',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add_circle_outline,
                        size: 30,
                        color: Colors.black,
                      ),
                      Text(
                        'で追加してください',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
