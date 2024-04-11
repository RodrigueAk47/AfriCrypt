import 'dart:convert';

import 'package:africrypt/Models/episodes_model.dart';
import 'package:flutter/services.dart';

class Saison {
  final int id;
  final String title;
  final String description;
  final String theme;
  final List<Episode> episodes;

  Saison(
      {required this.id,
      required this.title,
      required this.description,
      required this.theme,
      required this.episodes});

  factory Saison.fromJson(Map<String, dynamic> json) {
    var episodeList = json['episodes'] as List;
    List<Episode> episodes =
        episodeList.map((i) => Episode.fromJson(i)).toList();

    return Saison(
      id: json['numero'],
      title: json['titre'],
      theme: json['theme'],
      description: json['description'],
      episodes: episodes,
    );
  }
  static Future<List<Saison>> loadSaisonsFromAssets() async {
    String jsonString =
        await rootBundle.loadString('assets/data/database.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);

    var saisonList = jsonData['saison'] as List;
    List<Saison> saisons = saisonList.map((i) => Saison.fromJson(i)).toList();

    return saisons;
  }
}
