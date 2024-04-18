import 'dart:convert';

import 'package:africrypt/models/episodes_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Season {
  final int id;
  final String title;
  final String description;
  final String theme;
  final List<Episode> episodes;
  bool isUnlocked;

  Season({
    required this.id,
    required this.title,
    required this.description,
    required this.theme,
    required this.episodes,
    this.isUnlocked = false,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    var episodeList = json['episodes'] as List;
    List<Episode> episodes =
        episodeList.map((i) => Episode.fromJson(i)).toList();

    return Season(
      id: json['numero'],
      title: json['titre'],
      theme: json['theme'],
      description: json['description'],
      episodes: episodes,
    );
  }

  static Future<List<Season>> loadSaisonsFromAssets() async {
    String jsonString =
        await rootBundle.loadString('assets/data/database.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);

    var saisonList = jsonData['saison'] as List;
    List<Season> saisons = saisonList.map((i) => Season.fromJson(i)).toList();

    return saisons;
  }

  static Future<void> saveLastUnlockedSeason(int seasonNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_unlocked_season', seasonNumber);
  }

  static Future<bool> isSeasonUnlocked(int seasonNumber) async {
    final prefs = await SharedPreferences.getInstance();
    int lastUnlockedSeason = prefs.getInt('last_unlocked_season') ?? 0;
    return seasonNumber <= lastUnlockedSeason;
  }

  static Future<void> removeLastUnlockedSeason() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('last_unlocked_season');
  }
}
