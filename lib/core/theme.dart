import 'package:africrypt/Models/season_model.dart';
import 'package:africrypt/main.dart';
import 'package:flutter/material.dart';

class GameTheme {
  static const mainColor = Color(0xffdf2546);
  static const secondaryColor = Color(0xFFCECDEE);
  static const List<Color> colors = [
    mainColor,
    Color.fromARGB(255, 22, 146, 26),
    Color.fromARGB(255, 15, 118, 201),
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink
  ];

  static void refreshGlobalColor() async {
    int lastUnlockedSeason = await Season.getLastUnlockedSeason();
    globalColor = GameTheme.colors[lastUnlockedSeason - 1];
    colorStreamController.add(globalColor);
  }
}
