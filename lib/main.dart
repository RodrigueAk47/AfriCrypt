import 'package:africrypt/core/database.dart';
import 'package:africrypt/game/views/dashboard.dart';
import 'package:africrypt/game/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await DB().open();
  runApp(Game(database: database));
}

class Game extends StatefulWidget {
  final Database database;

  const Game({super.key, required this.database});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  Widget _homePage = const LoginView(); // Initialement la page de connexion

  Future<void> checkTableAndRedirect() async {
    final results = await widget.database.query('user');

    if (results.isNotEmpty) {
      setState(() {
        _homePage = const Dashboard();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkTableAndRedirect(); // Vérifier la table et rediriger au lancement
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AfriCrypt',
      home: _homePage,
    );
  }
}
