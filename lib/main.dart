import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';
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
  String _exp = '';

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
    prefs.setInt('key2', count);
  }

  getPreferenceString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      count = prefs.getInt('key2') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    getPreferenceList();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    setState(() {
      setPreferenceList();
    });
    sumMoney();
  }

  void sumMoney() {
    amount = todoList.join('+');
    Parser p = Parser();
    Expression exp = p.parse(amount);
    ContextModel cm = ContextModel();
    setState(() {
      _exp = exp.evaluate(EvaluationType.REAL, cm).toString();
      print(_exp);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('103万まで残り：' + '$_exp' + '円'),
      ),
      body: (todoList.isNotEmpty) ?
      SafeArea(
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
              child: Card(
                child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(child: Text('￥' + todoList[index])),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ) :
      SafeArea(
        child: const Center(
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
      floatingActionButton: FloatingActionButton(
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

        child: const Icon(Icons.add),
      ),
    );
  }
}
