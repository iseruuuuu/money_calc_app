import 'package:flutter/material.dart';
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
      home: GestureDetector(
        // onTap: () => FocusScope.of(context).unfocus(),
        onTap: () {

        },
        child :const TodoListPage(),
      ),
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

  @override
  void initState() {
    super.initState();
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

  void sumMoney() {
    amount = todoList.join('+');

    Parser p = Parser();
    Expression exp = p.parse(amount);
    ContextModel cm = ContextModel();
    _exp = exp.evaluate(EvaluationType.REAL, cm).toString();

    amount2 = todoList.join('+');
    final sum = '1030000-(' + amount2 + ')';

    Parser p2 = Parser();
    Expression exp2 = p2.parse(sum);
    ContextModel cm2 = ContextModel();
    _exp2 = exp2.evaluate(EvaluationType.REAL, cm2).toString();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Colors.red,
        ),
      ),
      body: (todoList.isNotEmpty) ?
      SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                             const Text(
                                '合計',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              Text( _exp + '円',
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                '残り',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              Text( _exp2 + '円',
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // CircularProgressIndicator(),
            // LinearProgressIndicator(),

            const SizedBox(height: 40),

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
                          const SnackBar(content: Text("削除しました"),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()
        // {sumMoney();},
        async {
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
        icon: const Icon(
          Icons.add,
          size: 30,

        ),
        label: const Text(
          '給料を追加',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
