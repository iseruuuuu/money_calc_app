import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        onTap: () => FocusScope.of(context).unfocus(),
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

  Future<void> setPreference() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList('key', todoList);
  }

  getPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoList = prefs.getStringList('key') ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    getPreference();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    setState(() {
      setPreference();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('給料明細'),
      ),
      body: (todoList.isNotEmpty) ?
      ListView.builder(
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
            child: Column(
              children: [
                Text('◯月◯日時点の合計額： 4000円'),
                SizedBox(
                  height: 100,
                  child: Card(
                    child: ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(todoList[index]),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ) :
      const Center(
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
      floatingActionButton: FloatingActionButton(
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
