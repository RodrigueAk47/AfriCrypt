import 'package:africrypt/models/story_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Episode {
  final int id;
  final String title;
  final String description;
  final Story stories;
  bool? isUnlocked;

  Episode({
    required this.id,
    required this.title,
    required this.description,
    required this.stories,
    this.isUnlocked = false,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['numero'],
      title: json['titre'],
      description: json['description'],
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
    String lastUnlockedEpisode = prefs.getString('last_unlocked_episode_$seasonNumber') ?? '0-0';
    List<String> parts = lastUnlockedEpisode.split('-');
    int lastUnlockedEpisodeNumber = int.parse(parts[1]);
    return lastUnlockedEpisodeNumber;
  }

  static Future<void> removeLastEpisode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('last_unlocked_episode');
  }
}
