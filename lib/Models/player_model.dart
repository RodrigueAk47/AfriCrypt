import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';

class PlayerModel {
  final String name;
  final bool gender;

  PlayerModel({required this.name, required this.gender});
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  Future<void> saveToSharedPreferences() async {
    final prefs = await _prefs;
    String playerJson = jsonEncode({
      'name': name,
      'gender': gender,
    });
    await prefs.setString('player', playerJson);
  }

  static Future<void> saveUserFirestores() async {
    final prefs = await SharedPreferences.getInstance();
    String? playerJson = prefs.getString('player');
    if (playerJson != null) {
      Map<String, dynamic> playerData = jsonDecode(playerJson);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('players')
            .doc(user.uid)
            .set({
          'name': playerData['name'],
          'gender': playerData['gender'],
        }, SetOptions(merge: true));
      }
    }
  }

  static Future<PlayerModel?> loadFromSharedPreferences() async {
    final prefs = await _prefs;
    String? playerJson = prefs.getString('player');
    if (playerJson != null && playerJson != 'null') {
      Map<String, dynamic> playerData = jsonDecode(playerJson);
      if (playerData.containsKey('name') && playerData.containsKey('gender')) {
        return PlayerModel(
            name: playerData['name'], gender: playerData['gender']);
      }
    }
    return null;
  }

  static Future<void> deletePlayerData() async {
    final prefs = await _prefs;
    await prefs.remove('player');
  }

  static Future<void> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  static Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> restoreFromFirestoreToSharedPreferences() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('players')
          .doc(user.uid)
          .get();
      Map<String, dynamic>? playerData;
      if (doc.exists) {
        playerData = {
          'name': doc.get('name'),
          'gender': doc.get('gender'),
        };
      } else {
        // Handle the case where the document does not exist.
        // This could be setting playerData to null or to default values.
        playerData = null; // or {'name': 'default', 'gender': 'default'};
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('player', jsonEncode(playerData));
    }
  }
}
