import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PlayerModel {
  final String name;
  final bool gender;

  PlayerModel({required this.name, required this.gender});
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> saveToSharedPreferences() async {
    final prefs = await _prefs;
    String playerJson = jsonEncode({
      'name': name,
      'gender': gender,
    });
    await prefs.setString('player', playerJson);
  }

  static Future<PlayerModel?> loadFromSharedPreferences() async {
    final prefs = await _prefs;
    String? playerJson = prefs.getString('player');
    if (playerJson != null) {
      Map<String, dynamic> playerData = jsonDecode(playerJson);
      return PlayerModel(
          name: playerData['name'], gender: playerData['gender']);
    } else {
      return null;
    }
  }

  Future<void> deletePlayerData() async {
    final prefs = await _prefs;
    await prefs.remove('player');
  }
}
