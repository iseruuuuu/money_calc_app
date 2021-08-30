//パスワードを作成

//登録

//ログイン

//If文で、初回は、登録画面を作る　＝＞　true falseをする。

//なんでもよき

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_calc_app/screen/main.dart';
import '../../model/color.dart';
import '../../component/number_calc_button.dart';
import 'package:holding_gesture/holding_gesture.dart';

import '../home_screen/home_screen.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {

  String expression = '';
  bool cancel = false;

  void numClick(String text) {
    if (expression.length >= 4) {}
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

  void allDelete(String text) {
    setState(() {
      expression = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: AppColor.white,
          elevation: 0,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const SizedBox(height: 40),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
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
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(top: 1, bottom: 1, right: 0, left: 0),
                  child: SizedBox(
                    width: 80,
                    height: 80,
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
          const SizedBox(height: 10),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberCalcButton(
                text: '0',
                textSize: 40,
                fillColor: 0xff424242,
                textColor: 0xFFFFFFFF,
                callback: numClick,
              ),
              NumberCalcButton(
                text: '00',
                textSize: 35,
                fillColor: 0xff424242,
                textColor: 0xFFFFFFFF,
                callback: numClick,
              ),
              NumberCalcButton(
                text: 'AC',
                textSize: 30,
                fillColor: 0xff424242,
                textColor: 0xFFFFFFFF,
                callback: allDelete,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 7,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColor.red2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {

                  //TODO パスワードを確認する

                  //TODO 不正解 => ダイアログ？

                  //TODO 正解 => 画面遷移

                  if(expression == '100') {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return const TodoListPage();
                      },
                        fullscreenDialog: true,
                      ),
                    );
                  }else{
                  }
                },
                child: const Text(
                  'ログイン',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
