import 'dart:io';
import 'package:money_calc_app/model/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TODODB.db");
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    return await db.execute("CREATE TABLE Todo ("
        "id TEXT PRIMARY KEY,"
        "title TEXT,"
        "dueDate TEXT,"
        "number TEXT,"
        "note TEXT"
        ")");
  }

  static final _tableName = "TODO";

  createTodo(Todo todo) async {
    final db = await database;
    var res = await db.insert(_tableName, todo.toMap());
    return res;
  }

  getAllTodos() async {
    final db = await database;
    var res = await db.query(_tableName);
    List<Todo> list =
        res.isNotEmpty ? res.map((e) => Todo.fromMap(e)).toList() : [];
    return list;
  }

  updateTodo(Todo todo) async {
    final db = await database;
    var res = db
      ..update(_tableName, todo.toMap(), where: "id = ?", whereArgs: [todo.id]);
    return res;
  }

  deleteTodo(String id) async {
    final db = await database;
    var res = db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    return res;
  }

  deleteAllTodo() async {
    final db = await database;
    var res = db.delete('id');
    return res;
  }
}
