import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:storage/view/student.dart';

class DatabaseHalper {
  String dbName = 'task.db';
  String tableName = 'task';
  String columName = 'name';
  String columId = 'id';
  String columGender = 'title';
  String columage = 'isDone';
  String columMajor = 'data';
  // Database? _database;
  static final DatabaseHalper _instance = DatabaseHalper._internal();
  factory DatabaseHalper() => _instance;
  DatabaseHalper._internal();

  Future<Database> initDataBase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demoUser.db');

// open the database
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE $tableName ($columId INTEGER PRIMARY KEY AUTOINCREMENT,$columGender TEXT , $columName TEXT , $columage INTEGER ,   $columMajor TEXT)');
    });
  }

  Future insertTask(Student stu) async {
    log("inProgress");
    var db = await DatabaseHalper().initDataBase();
    await db.insert(tableName, stu.toMap());
    log("AddSuccess");
  }

  Future<void> updateTask({required Student stu}) async {
    log("Update");
    var db = await DatabaseHalper().initDataBase();
    await db.update(DatabaseHalper().tableName, stu.toMap(),
        where: '$columId=?', whereArgs: [stu.id]);
    log("UpdateSuccess");
  }

  Future<void> deleteTask({required int id}) async {
    log("Delote");
    var db = await DatabaseHalper().initDataBase();
    await db.delete(DatabaseHalper().tableName,
        where: '${DatabaseHalper().columId}=?', whereArgs: [id]);
    log("DeloteSuccess");
  }

  Future<List<Student>> getStudent() async {
    var db = await DatabaseHalper().initDataBase();
    List<Map<String, dynamic>> result = await db.query(tableName);
    return result.map((e) => Student.fromMap(e)).toList();
  }

  Future<List<Student>> searchStudent(String? search) async {
    var db = await DatabaseHalper().initDataBase();
    List<Map<String, dynamic>> result = await db
        .query(tableName, where: 'name LIKE ?', whereArgs: ['$search%']);
    log(result.toString());
    return result.map((e) => Student.fromMap(e)).toList();
  }
}
