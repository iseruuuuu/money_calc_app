import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_calc_app/database/todo_bloc.dart';
import 'package:money_calc_app/model/todo.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../model/admob.dart';
import '../model/color.dart';
import '../component/number_calc_button.dart';
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

  void allDelete(String text) {
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
                const Text(
                  '￥',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  expression,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 1),
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
                            child: const Text(
                              '⌫',
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
                    }
                  }
                },
                child: const Text(
                  'リスト追加',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'キャンセル',
                  style: TextStyle(
                    fontSize: 20,
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
