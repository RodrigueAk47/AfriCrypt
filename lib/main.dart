import 'package:africrypt/game/views/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Game());
}

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AfriCrypt',
      home: LoginView(),
    );
  }
}
