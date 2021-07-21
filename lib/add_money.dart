import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cal/number_calc_button.dart';
import 'package:holding_gesture/holding_gesture.dart';

class TodoAddPage extends StatefulWidget {

  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {

  String expression = '';
  bool cancel = false;

  void numClick(String text) {
    if (expression.length >= 11) {}
    else{
      setState(() => expression += text);
    }
  }


  void delete() {
    setState(() {
      if(expression.isEmpty) {}
      else{
        final pos = expression.length - 1;
        expression = expression.substring(0, pos);
      }
    });
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        expression,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        ),
                        maxLines: 1,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 1, bottom: 1, right: 0, left: 0),
                        child: SizedBox(
                          width: 73,
                          height: 73,
                          child: HoldDetector(
                            onHold: () {
                              delete();
                              HapticFeedback.mediumImpact();
                            },
                            child: Theme(
                              data: ThemeData(splashColor: Colors.white),
                              child: Material(
                                elevation: 0,
                                clipBehavior: Clip.hardEdge,
                                color: Colors.transparent,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  onPressed: () {
                                    delete();
                                    HapticFeedback.selectionClick();
                                  },
                                  child: const Text('⌫',
                                    style: TextStyle(
                                      fontSize: 40,
                                      // fontSize: 50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                  height: 50,
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
                    child: const Text(
                      'リスト追加',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'キャンセル',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
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
