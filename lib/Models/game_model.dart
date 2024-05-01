import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameModel {
  final String title;
  final String enigme;
  final String hint;
  final List<String> words;

  GameModel({
    required this.title,
    required this.enigme,
    required this.words,
    required this.hint,
  });
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  factory GameModel.fromJson(Map<String, dynamic> json) {
    var motsList = json['mots'] as List;
    List<String> mots = motsList.map((i) => i.toString()).toList();

    return GameModel(
      title: json['titre'],
      enigme: json['enigme'],
      hint: json['indice'],
      words: mots,
    );
  }
  static Future<void> unlockHint(int seasonId, int episodeId) async {
    final prefs = await SharedPreferences.getInstance();
    String key = 'hintUnlocked_$seasonId';
    String currentUnlocked = prefs.getString(key) ?? '';
    String episodeStr = episodeId.toString().padLeft(2, '0');
    if (!currentUnlocked.contains(episodeStr)) {
      currentUnlocked += episodeStr;
    }
    await prefs.setString(key, currentUnlocked);
  }

  static Future<bool> isHintUnlocked(int seasonId, int episodeId) async {
    final prefs = await SharedPreferences.getInstance();
    String key = 'hintUnlocked_$seasonId';
    String currentUnlocked = prefs.getString(key) ?? '';
    String episodeStr = episodeId.toString().padLeft(2, '0');
    return currentUnlocked.contains(episodeStr);
  }

  static Future<void> saveHintsToFirebase(int seasonId) async {
    final prefs = await SharedPreferences.getInstance();
    String key = 'hintUnlocked_$seasonId';
    String currentUnlocked = prefs.getString(key) ?? '';

    // Sauvegarder sur Firebase
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('players').doc(user.uid).update({
        key: currentUnlocked,
      });
    }
  }

  static Future<void> restoreHintFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('players').doc(user.uid).get();
      if (doc.exists) {
        final prefs = await SharedPreferences.getInstance();
        final data = doc.data()!;
        for (var key in data.keys) {
          if (key.startsWith('hintUnlocked_')) {
            final allHint = data[key] ?? '';
            await prefs.setString(key, allHint);
          }
        }
      }
    }
  }
}
