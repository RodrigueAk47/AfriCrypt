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

  Future<void> insertUser(String name, bool gender) async {
    final database = await open();
    await database.execute(
      'INSERT INTO user(name, gender) VALUES (?, ?)',
      [name, gender ? 1 : 0],
    );
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final database = await open();
    final results = await database.query('user');

    return results.cast<Map<String, dynamic>>();
  }

  Future<void> deleteAllUsers() async {
    final database = await open();
    await database.execute('DELETE FROM user');
  }
}
