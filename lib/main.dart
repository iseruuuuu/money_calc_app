import 'package:flutter/material.dart';
import 'package:money_calc_app/component/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_expressions/math_expressions.dart';
import 'add_money.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<String> todoList = [];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int count = 0;
  String amount = '';
  String amount2 = '';
  String _exp = '';
  String _exp2 = '';
  String amount3 = '';
  String amount4 = '';
  String _exp3 = '';
  String _exp4 = '';

  @override
  void initState() {
    super.initState();

    //TODO 読み込む間に、Loading画面を入れたい。
    getPreferenceList();
    getPreferenceString();
  }

  void loading() {}

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
    amount3 = amount + '/' + '10';
    Parser p = Parser();
    ContextModel cm = ContextModel();
    Expression exp = p.parse(amount3);
    _exp3 = exp.evaluate(EvaluationType.REAL, cm).toString();
    _exp = _exp3.replaceAll('.', '');
    amount2 = todoList.join('+');
    final sum = '( 1030000-(' + amount2 + ') ) / 10';
    Parser p2 = Parser();
    Expression exp2 = p2.parse(sum);
    ContextModel cm2 = ContextModel();
    _exp4 = exp2.evaluate(EvaluationType.REAL, cm2).toString();
    _exp2 = _exp4.replaceAll('.', '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: (todoList.isNotEmpty) ?
      PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: AppColor.red2,
          elevation: 0,
        ),
      ) :
      PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: AppColor.white,
          elevation: 0,
        ),
      ),
      body: (todoList.isNotEmpty) ?
      Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SafeArea(
            child: Column(
              children: [
                Container(
                  color: AppColor.red2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                const SizedBox(height: 20),
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
                          if (direction == DismissDirection.endToStart) {
                            Scaffold.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("削除しました"),
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.white70,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: Text(
                                      '￥' + todoList[index],
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
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
        ],
      ) :
      const SafeArea(
        child: Center(
          child: Text(
            '給料の記録がありません。\n'
                '＋ボタンで追加してください。',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width / 5,
        height: MediaQuery.of(context).size.width / 5,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFFEA6762),
          onPressed: () async {
            final newListText = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return TodoAddPage();
              }),
            );
            if (newListText != null) {
              setState(() {
                todoList.add(newListText);
              });
            }
          },
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFEA6762),
        notchMargin: 10.0,
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(),
          StadiumBorder(
            side: BorderSide(),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            SizedBox(height: 50, child: Text('')),
            SizedBox(height: 50, child: Text('')),
          ],
        ),
      ),

      // floatingActionButton: Container(
      //   width: 120,
      //   height: 120,
      //   child: FloatingActionButton.extended(
      //     onPressed: () async {
      //       final newListText = await Navigator.of(context).push(
      //         MaterialPageRoute(builder: (context) {
      //           return TodoAddPage();
      //         }),
      //       );
      //       if (newListText != null) {
      //         setState(() {
      //           todoList.add(newListText);
      //         });
      //       }
      //     },
      //     label: Column(
      //       children: const [
      //         Icon(
      //           Icons.add_circle_outline,
      //           size: 40,
      //         ),
      //         Text(
      //           '給料を追加',
      //           style: TextStyle(
      //             fontSize: 20,
      //             color: Colors.white,
      //           ),
      //         ),
      //       ],
      //     ),
      //     backgroundColor: const Color(0xFFEA6762),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
