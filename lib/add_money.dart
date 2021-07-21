import 'package:flutter/material.dart';

class TodoAddPage extends StatefulWidget {

  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {

  String _text = '';
  bool cancel = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('リスト追加'),
      ),
      body:  GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: const EdgeInsets.only(top: 50, left: 30,right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 8,),
                Container(
                  height: 300,
                  color: const Color(0xffeeeeee),
                  padding: const EdgeInsets.all(10.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 200.0,
                    ),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: SizedBox(
                          height: 190.0,
                          child: TextField(
                            maxLines: 10,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (String value) {
                              setState(() {
                                _text  = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  // 横幅いっぱいに広げる
                  width: double.infinity,
                  // リスト追加ボタン
                  child: ElevatedButton(
                    onPressed: () {
                      if (cancel == true) {
                        var now = new DateTime.now();
                        //var formatter = DateFormat('yyyy/MM/dd  HH:mm');
                        // String formattedDate = formatter.format(now); // 2016-01-25
                        final post = '\n'
                        // '$formattedDate \n'
                            '\n'
                            '$_text';
                        Navigator.of(context).pop(post);
                      }else{
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Center(
                                  child: Text(
                                    "\n"
                                        "ツイートしましたか？",style: TextStyle(color: Colors.black),)),
                              content: const Text("リストの追加の前にツイートしておくことをオススメします。"),
                              actions: <Widget>[
                                // ボタン領域
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20,left: 0),
                                        child: TextButton(
                                          child: const Text("ツイートする",style: TextStyle(fontSize: 15),
                                          ),
                                          onPressed: () => Navigator.pop(context),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 0,left: 20),
                                        child: TextButton(
                                          child: Text("リストに追加",style: const TextStyle(fontSize: 15),),
                                          onPressed: () {
                                            cancel = true;
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text('リスト追加', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10.0),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  // 横幅いっぱいに広げる
                  width: double.infinity,
                  // キャンセルボタン
                  child: TextButton(
                    // ボタンをクリックした時の処理
                    onPressed: () {
                      //TODO キャンセルダイアログを出す
                      Navigator.of(context).pop();
                    },
                    child: const Text('キャンセル'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
