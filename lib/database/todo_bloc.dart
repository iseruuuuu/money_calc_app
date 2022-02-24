import 'dart:async';
import 'package:money_calc_app/database/todo_provider.dart';
import 'package:money_calc_app/model/todo.dart';
import 'package:rxdart/rxdart.dart';

class TodoBloc {
  final _todoController = BehaviorSubject<List<Todo>>();

  Stream<List<Todo>> get todoStream => _todoController.stream;

  getTodo() async {
    _todoController.sink.add(await DBProvider.db.getAllTodo());
  }

  TodoBloc() {
    getTodo();
  }

  dispose() {
    //多くのアプリケーションは1つのデータベースを使用し、データベースを閉じる必要はありません（アプリケーションが終了するとデータベースは閉じられます）。リソースを解放したい場合は、データベースを閉じることができます。
    _todoController.close();
  }

  create(Todo todo) {
    todo.assignUUID();
    DBProvider.db.createTodo(todo);
    getTodo();
  }

  update(Todo todo) {
    DBProvider.db.updateTodo(todo);
    getTodo();
  }

  delete(String id) {
    DBProvider.db.deleteTodo(id);
    getTodo();
  }

  allDelete() {
    DBProvider.db.deleteAllTodo();
    getTodo();
  }
}
