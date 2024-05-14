import 'package:africrypt/models/story_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Episode {
  final int id;
  final String title;
  final Story stories;

  bool? isUnlocked;

  Episode({
    required this.id,
    required this.title,
    required this.stories,
    this.isUnlocked = false,
  });

  static final _firestore = FirebaseFirestore.instance;

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['numero'],
      title: json['titre'],

      stories: Story.fromJson(json['stories']),
    );
  }

  static Future<void> saveLastUnlockedEpisode(
      int seasonNumber, int episodeNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'last_unlocked_episode_$seasonNumber', '$seasonNumber-$episodeNumber');
  }

  static Future<bool> isEpisodeUnlocked(
      int seasonNumber, int episodeNumber) async {
    if (episodeNumber == 1) {
      return true; // Episode 1 of any season is always unlocked
    }
    final prefs = await SharedPreferences.getInstance();
    String lastUnlockedEpisode =
        prefs.getString('last_unlocked_episode_$seasonNumber') ?? '0-0';
    List<String> parts = lastUnlockedEpisode.split('-');
    int lastUnlockedSeason = int.parse(parts[0]);
    int lastUnlockedEpisodeNumber = int.parse(parts[1]);
    return seasonNumber < lastUnlockedSeason ||
        (seasonNumber == lastUnlockedSeason &&
            episodeNumber <= lastUnlockedEpisodeNumber + 1);
  }

  static Future<int> getLastUnlockedEpisode(int seasonNumber) async {
    final prefs = await SharedPreferences.getInstance();
    String lastUnlockedEpisode =
        prefs.getString('last_unlocked_episode_$seasonNumber') ?? '0-0';
    List<String> parts = lastUnlockedEpisode.split('-');
    int lastUnlockedEpisodeNumber = int.parse(parts[1]);
    return lastUnlockedEpisodeNumber;
  }

  static Future<void> deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<void> saveLastUnlockedEpisodeOnFirebase(
      int seasonNumber, int episodeNumber) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('players').doc(user.uid).set({
        'last_unlocked_episode_$seasonNumber': '$seasonNumber-$episodeNumber',
      }, SetOptions(merge: true));
    }
  }

  static Future<void> restoreLastUnlockedEpisodes() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('players').doc(user.uid).get();
      if (doc.exists) {
        final prefs = await SharedPreferences.getInstance();
        final data = doc.data()!;
        for (var key in data.keys) {
          if (key.startsWith('last_unlocked_episode_')) {
            final lastUnlockedEpisode = data[key] ?? '0-0';
            await prefs.setString(key, lastUnlockedEpisode);
          }
        }
      }
    }
  }
}
