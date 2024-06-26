import 'package:anunciosapp/models/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:anunciosapp/helpers/task_helper.dart';

class DatabaseHelper {
  Database? _db;

  static final DatabaseHelper _instace = DatabaseHelper.internal();

  factory DatabaseHelper() => _instace;

  DatabaseHelper.internal();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database?> initDb() async {
    final databasepath = await getDatabasesPath();
    final path = join(databasepath, 'taskDatabase.db');

    try {
      return _db = await openDatabase(path,
          version: 1, onCreate: _onCreateDB, onUpgrade: _onUpgradeDB);
    } catch (e) {
      print(e);
    }
  }

  Future _onCreateDB(Database db, int newVersion) async {
    await db.execute(TaskHelper.createScript);
  }

  Future _onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute("DROP TABLE ${TaskHelper.tableName};");
      await _onCreateDB(db, newVersion);
    }
  }

  Future<Todo?> saveTask(Todo task) async {
    Database? db = await DatabaseHelper().db;
    if (db != null) {
      task.id = await db.insert(TaskHelper.tableName, task.toMap());
      return task;
    }
    return null;
  }

  Future<List<Todo>?> getAll() async {
    Database? db = await DatabaseHelper().db;
    if (db == null) return null;

    List<Map<String, dynamic>> returnedTasks =
        await db.query(TaskHelper.tableName, columns: [
      TaskHelper.idColumn,
      TaskHelper.textColumn,
      TaskHelper.doneColumn,
      TaskHelper.imagePathColumn
    ]);

    List<Todo> tasks = [];

    for (Map<String, dynamic> taskMap in returnedTasks) {
      tasks.add(Todo.fromMap(taskMap));
    }
    return tasks;
  }

  Future<Todo?> getById(int id) async {
    Database? db = await DatabaseHelper().db;
    if (db == null) return null;

    List<Map<String, dynamic>> returnedTask = await db.query(
      TaskHelper.tableName,
      columns: [
        TaskHelper.idColumn,
        TaskHelper.textColumn,
        TaskHelper.doneColumn,
        TaskHelper.imagePathColumn
      ],
      where: "$TaskHelper.idColumn = ?",
      whereArgs: [id],
    );

    if (returnedTask.isNotEmpty) {
      Map<String, dynamic> taskMap = returnedTask.first;
      if (taskMap.containsKey(TaskHelper.idColumn) &&
          taskMap.containsKey(TaskHelper.textColumn) &&
          taskMap.containsKey(TaskHelper.doneColumn) &&
          taskMap.containsKey(TaskHelper.imagePathColumn)) {
        return Todo.fromMap(taskMap);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<int?> editTask(Todo task) async {
    Database? db = await DatabaseHelper().db;
    if (db == null) return null;

    return await db.update(TaskHelper.tableName, task.toMap(),
        where: "$TaskHelper.idColumn = ?", whereArgs: [task.id]);
  }

  Future<int?> deleteTask(Todo task) async {
    Database? db = await DatabaseHelper().db;
    if (db == null) return null;

    return await db.delete(TaskHelper.tableName,
        where: "$TaskHelper.idColumn = ?", whereArgs: [task.id]);
  }
}
