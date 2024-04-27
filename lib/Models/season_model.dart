import 'dart:convert';
import 'package:africrypt/models/episodes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Season {
  final int id;
  final String title;
  final String description;
  final List<Episode> episodes;
  bool isUnlocked;

  Season({
    required this.id,
    required this.title,
    required this.description,
    required this.episodes,
    this.isUnlocked = false,
  });

  static final _firestore = FirebaseFirestore.instance;

  factory Season.fromJson(Map<String, dynamic> json) {
    var episodeList = json['episodes'] as List;
    List<Episode> episodes =
        episodeList.map((i) => Episode.fromJson(i)).toList();

    return Season(
      id: json['numero'],
      title: json['titre'],
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

  static Future<int> getLastUnlockedSeason() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('last_unlocked_season') ?? 1;
  }

  static Future<bool> isSeasonUnlocked(int seasonNumber) async {
    final prefs = await SharedPreferences.getInstance();
    int lastUnlockedSeason = prefs.getInt('last_unlocked_season') ?? 1;
    return seasonNumber <= lastUnlockedSeason;
  }

  static Future<void> removeLastUnlockedSeason() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('last_unlocked_season');
  }

  static Future<void> saveLastUnlockedSeasonOnFirebase() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int lastUnlockedSeason = prefs.getInt('last_unlocked_season') ?? 1;
      await _firestore.collection('players').doc(user.uid).set({
        'last_unlocked_season': lastUnlockedSeason,
      }, SetOptions(merge: true));
    }
  }

  static Future<void> restoreLastUnlockedSeason() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('players').doc(user.uid).get();
      int? lastUnlockedSeason;
      if (doc.exists && doc.data()!.containsKey('last_unlocked_season')) {
        lastUnlockedSeason = doc.get('last_unlocked_season') ?? 0;
      } else {
        // Handle the case where the document does not exist or does not contain the field 'last_unlocked_season'.
        // This could be setting lastUnlockedSeason to null or to a default value.
        lastUnlockedSeason = 1; // set a default value
      }

      final prefs = await SharedPreferences.getInstance();
      if (lastUnlockedSeason != null) {
        await prefs.setInt('last_unlocked_season', lastUnlockedSeason);
      }
    }
  }
}
