import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_calc_app/database/todo_bloc.dart';
import 'package:money_calc_app/model/todo.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../model/color.dart';
import '../component/add_screen/number_calc_button.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:intl/intl.dart';

class AddScreen extends StatefulWidget {
  final DateFormat _format = DateFormat("yyyy/MM/dd HH:mm");
  final TodoBloc? todoBloc;
  final Todo todo;
  final Todo _newTodo = Todo.newTodo();

  AddScreen({
    Key? key,
    this.todoBloc,
    required this.todo,
  }) : super(key: key) {
    //初期値
    _newTodo.id = todo.id;
    _newTodo.dueDate = todo.dueDate;
  }

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String expression = '';
  bool cancel = false;

  void numClick(String text) {
    if (expression.length >= 7) {
    } else {
      setState(() => expression += text);
    }
  }

  void delete() {
    setState(() {
      if (expression.isEmpty) {
      } else {
        final pos = expression.length - 1;
        expression = expression.substring(0, pos);
      }
    });
  }

  void allDelete() {
    setState(() {
      expression = '';
    });
  }

  void alertSnackBar() {
    showTopSnackBar(
      context,
      const CustomSnackBar.error(
        message: "０以上の入力をお願いします!!",
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('yyyy/MM');

    String date = outputFormat.format(now);
    widget._newTodo.dueDate = date;
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
          //TODO 次のアプデにする。
          // AdmobBanner(
          //   adUnitId: AdMob().getBannerAdUnitId(),
          //   adSize: AdmobBannerSize(
          //     width: MediaQuery.of(context).size.width.toInt(),
          //     height: AdMob().getHeight(context).toInt(),
          //     name: 'SMART_BANNER',
          //   ),
          // ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '￥',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 10,
                  ),
                ),
                Text(
                  expression,
                  style: TextStyle(
                    color: Colors.black,
                    // fontSize: 40,
                    fontSize: MediaQuery.of(context).size.width / 10,
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 1),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.height / 10,
                    height: MediaQuery.of(context).size.height / 10,
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
                            child: Text(
                              '⌫',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 10,
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
          // const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberCalcButton(
                number: 7,
                text: '7',
                // textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                callback: numClick,
                onTap: () {
                  numClick('7');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                number: 8,
                text: '8',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                callback: numClick,
                onTap: () {
                  numClick('8');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                number: 9,
                text: '9',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                callback: numClick,
                onTap: () {
                  numClick('9');
                  HapticFeedback.selectionClick();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberCalcButton(
                number: 4,
                text: '4',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                callback: numClick,
                onTap: () {
                  numClick('4');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                number: 5,
                text: '5',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                callback: numClick,
                onTap: () {
                  numClick('5');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                number: 6,
                text: '6',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                callback: numClick,
                onTap: () {
                  numClick('6');
                  HapticFeedback.selectionClick();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberCalcButton(
                number: 1,
                text: '1',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                callback: numClick,
                onTap: () {
                  numClick('1');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                number: 2,
                text: '2',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                callback: numClick,
                onTap: () {
                  numClick('2');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                number: 3,
                text: '3',
                //textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                callback: numClick,
                onTap: () {
                  numClick('3');
                  HapticFeedback.selectionClick();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberCalcButton(
                number: 0,
                text: '0',
                // textSize: 40,
                textSize: MediaQuery.of(context).size.width / 8,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                callback: numClick,
                onTap: () {
                  numClick('0');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                number: 0,
                text: '00',
                //textSize: 35,
                textSize: MediaQuery.of(context).size.width / 11,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                callback: numClick,
                onTap: () {
                  numClick('00');
                  HapticFeedback.selectionClick();
                },
              ),
              NumberCalcButton(
                onTap: () {
                  allDelete();
                },
                number: 0,
                text: 'AC',
                //textSize: 30,
                textSize: MediaQuery.of(context).size.width / 11,
                fillColor: AppColor.grey3,
                textColor: Colors.black,
                callback: allDelete,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColor.red2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (expression == '') {
                  } else if (expression == '0') {
                    alertSnackBar();
                  } else if (expression == '00') {
                    alertSnackBar();
                  } else if (expression == '000') {
                    alertSnackBar();
                  } else if (expression == '0000') {
                    alertSnackBar();
                  } else if (expression == '00000') {
                    alertSnackBar();
                  } else if (expression == '000000') {
                    alertSnackBar();
                  } else if (expression == '0000000') {
                    alertSnackBar();
                  } else {
                    final post = '$expression';
                    if (widget._newTodo.id != null) {
                      Navigator.of(context).pop(post);
                      widget.todoBloc?.create(widget._newTodo);

                      print(widget._newTodo.id);
                    }
                  }
                },
                child: Text(
                  'リスト追加',
                  style: TextStyle(
                    color: Colors.white,
                    // fontSize: 25,
                    fontSize: MediaQuery.of(context).size.width / 20,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'キャンセル',
                  style: TextStyle(
                    // fontSize: 20,
                    fontSize: MediaQuery.of(context).size.width / 20,
                    color: AppColor.red2,
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
