import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {


  Future<Database> open() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) => db.execute(
        'CREATE TABLE user(name TEXT PRIMARY KEY, gender BOOLEAN)',
      ),
      version: 1,
    );
    return database;
  }
}