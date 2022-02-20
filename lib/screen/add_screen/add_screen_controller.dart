import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_calc_app/database/todo_bloc.dart';
import 'package:money_calc_app/model/todo.dart';

class AddScreenController extends GetxController {
  var expression = ''.obs;
  var cancel = false.obs;
  final DateFormat _format = DateFormat("yyyy/MM/dd HH:mm");
  final TodoBloc todoBloc = TodoBloc();
  final Todo todo = Todo();
  final Todo _newTodo = Todo.newTodo();

  @override
  void onInit() {
    super.onInit();
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('yyyy/MM');

    _newTodo.id = Todo.newTodo().id;
    //_newTodo.dueDate = todo.dueDate;
    String date = outputFormat.format(now);
    _newTodo.dueDate = date;
  }

  void numClick(String text) {
    if (expression.value.length >= 6) {
    } else {
      expression.value += text;
    }
  }

  void delete() {
    if (expression.value.isEmpty) {
    } else {
      final pos = expression.value.length - 1;
      expression.value = expression.substring(0, pos);
    }
  }

  void allDelete() {
    expression.value = '';
  }

  void alertSnackBar() {
    Get.snackbar(
      "",
      "",
      titleText: const Text(
        '０以上の入力をお願いします!!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      messageText: const Text(
        '０以上の入力をお願いします!!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      colorText: Colors.black,
      icon: const Icon(
        Icons.person,
        color: Colors.white,
        size: 40,
      ),
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
    );
  }

  void onTap() {
    if (expression.value == '') {
    } else if (expression.value == '0') {
      alertSnackBar();
    } else if (expression.value == '00') {
      alertSnackBar();
    } else if (expression.value == '000') {
      alertSnackBar();
    } else if (expression.value == '0000') {
      alertSnackBar();
    } else if (expression.value == '00000') {
      alertSnackBar();
    } else if (expression.value == '000000') {
      alertSnackBar();
    } else if (expression.value == '0000000') {
      alertSnackBar();
    } else {
      final post = '$expression';
      if (_newTodo.id != null) {
        // Get.back();
        // print(expression);
        // print(_newTodo.id);
        // print(_newTodo.dueDate);
        Navigator.pop(Get.context!, expression.value);
        todoBloc.create(_newTodo);
        expression.value = '';
      }
    }
  }

  void onTapBack() {
    Get.back();
  }
}
