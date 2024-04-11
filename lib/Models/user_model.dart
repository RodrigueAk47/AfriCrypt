

/*
class User {
  final String username;
  final bool gender;

  const User({required this.username, required this.gender});

  static Future<Database> open() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'user.db'),
      onCreate: (db, version) => db.execute(
        'CREATE TABLE user(name TEXT PRIMARY KEY, gender BOOLEAN)',
      ),
      version: 1,
    );
    return db;
  }

  static Future<void> insertUser(User user) async {
    final db = await open();
    await db.execute(
      'INSERT INTO user(name, gender) VALUES (?, ?)',
      [user.username, user.gender ? 1 : 0],
    );
  }

  static Future<Map<String, dynamic>?> getFirstUser() async {
    final db = await open();
    final results = await db.query('user', limit: 1);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null; // No user found
    }
  }

  static Future<void> deleteAllUsers() async {
    final database = await open();
    await database.execute('DELETE FROM user');
  }
}
*/