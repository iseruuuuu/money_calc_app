import 'package:uuid/uuid.dart';

class Todo {
  String? id;

  // DateTime? dueDate;
  String? dueDate;

  Todo({
    this.id,
    this.dueDate,
  });

  Todo.newTodo() {
    //dueDate = DateTime.now();
    dueDate = '';
    id = const Uuid().v4();
  }

  assignUUID() {
    id = const Uuid().v4();
  }

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
      id: json["id"],
      // DateTime型は文字列で保存されているため、DateTime型に変換し直す
      //dueDate: DateTime.parse(json["dueDate"]).toLocal(),
      dueDate: json["dueDate"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        // sqliteではDate型は直接保存できないため、文字列形式で保存する
        //"dueDate": dueDate?.toUtc().toIso8601String(),
        "dueDate": dueDate,
      };
}
