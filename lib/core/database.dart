import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../features/auth.dart';

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

  Future<void> insertUser(User user) async {
    final database = await open();
    await database.execute(
      'INSERT INTO user(name, gender) VALUES (?, ?)',
      [user.username, user.gender ? 1 : 0],
    );
  }


  Future<Map<String, dynamic>?> getFirstUser() async {
    final db = await open();
    final results = await db.query('user', limit: 1);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null; // No user found
    }
  }

  Future<void> deleteAllUsers() async {
    final database = await open();
    await database.execute('DELETE FROM user');
  }
}
