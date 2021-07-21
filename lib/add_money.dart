import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'cal/number_calc_button.dart';

class TodoAddPage extends StatefulWidget {

  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {

  String expression = '';
  bool cancel = false;

  void numClick(String text) {
    setState(() => expression += text);
  }



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
                Text(expression),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NumberCalcButton(
                      text: '7',
                      textSize: 40,
                      fillColor: 0xff424242,
                      textColor: 0xFFFFFFFF,
                      callback: numClick,
                    ),
                    NumberCalcButton(
                      text: '8',
                      textSize: 40,
                      fillColor: 0xff424242,
                      textColor: 0xFFFFFFFF,
                      callback: numClick,
                    ),
                    NumberCalcButton(
                      text: '9',
                      textSize: 40,
                      fillColor: 0xff424242,
                      textColor: 0xFFFFFFFF,
                      callback: numClick,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NumberCalcButton(
                      text: '4',
                      textSize: 40,
                      fillColor: 0xff424242,
                      textColor: 0xFFFFFFFF,
                      callback: numClick,
                    ),
                    NumberCalcButton(
                      text: '5',
                      textSize: 40,
                      fillColor: 0xff424242,
                      textColor: 0xFFFFFFFF,
                      callback: numClick,
                    ),
                    NumberCalcButton(
                      text: '6',
                      textSize: 40,
                      fillColor: 0xff424242,
                      textColor: 0xFFFFFFFF,
                      callback: numClick,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NumberCalcButton(
                      text: '1',
                      textSize: 40,
                      fillColor: 0xff424242,
                      textColor: 0xFFFFFFFF,
                      callback: numClick,
                    ),
                    NumberCalcButton(
                      text: '2',
                      textSize: 40,
                      fillColor: 0xff424242,
                      textColor: 0xFFFFFFFF,
                      callback: numClick,
                    ),
                    NumberCalcButton(
                      text: '3',
                      textSize: 40,
                      fillColor: 0xff424242,
                      textColor: 0xFFFFFFFF,
                      callback: numClick,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {

                      var now = new DateTime.now();
                      //var formatter = DateFormat('yyyy/MM/dd  HH:mm');
                      // String formattedDate = formatter.format(now); // 2016-01-25
                      final post = '\n'
                      // '$formattedDate \n'
                          '\n'
                          '$expression';
                      Navigator.of(context).pop(post);
                    },
                    child: const Text('リスト追加', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {

                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(width: 10.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
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
