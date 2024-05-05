import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerModel {
  final String name;
  final bool gender;
  int? coins = 3;

  PlayerModel({
    required this.name,
    required this.gender,
    this.coins,
  });

  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static final user = FirebaseAuth.instance.currentUser;

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
          'coins': playerData['coins'],
        }, SetOptions(merge: true));
      }
    }
  }

  static Future<void> decrementCoins() async {
    final prefs = await SharedPreferences.getInstance();
    String? playerJson = prefs.getString('player');
    if (playerJson != null) {
      Map<String, dynamic> playerData = jsonDecode(playerJson);
      int currentCoins = playerData['coins'] ?? 0;
      if (currentCoins > 0) {
        playerData['coins'] = currentCoins - 1;
        playerJson = jsonEncode(playerData);
        await prefs.setString('player', playerJson);


      }
    }
  }

  Future<void> saveToSharedPreferences() async {
    final prefs = await _prefs;
    String playerJson = jsonEncode({
      'name': name,
      'gender': gender,
      'coins': coins ?? 3,
    });
    await prefs.setString('player', playerJson);
  }

  static Future<PlayerModel?> loadFromSharedPreferences() async {
    final prefs = await _prefs;
    String? playerJson = prefs.getString('player');
    if (playerJson != null && playerJson != 'null') {
      Map<String, dynamic> playerData = jsonDecode(playerJson);
      if (playerData.containsKey('name') &&
          playerData.containsKey('gender') &&
          playerData.containsKey('coins')) {
        return PlayerModel(
            name: playerData['name'],
            gender: playerData['gender'],
            coins: playerData['coins']);
      }
    }
    return null;
  }

  static Future<void> deletePlayerData() async {
    final prefs = await _prefs;
    await prefs.clear();
  }

  static Future<String?> signUpWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (defaultTargetPlatform == TargetPlatform.android) {
        user!.sendEmailVerification();
      }
      return null; // return null if there's no error
    } on FirebaseAuthException catch (e) {
      // Handle errors
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'email-already-in-use':
          return 'Cette adresse email est deja utilisée.';
        default:
          return 'An unknown error occurred: ${e.code}';
      }
    }
  }

  static Future<String?> signInWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null; // return null if there's no error
    } on FirebaseAuthException catch (e) {
      // Handle errors
      switch (e.code) {
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided for that user.';
        default:
          return 'Adresse ou mot de passe incorrect';
      }
    }
  }

  static Future<void> signOutWithEmail() async {
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
          'coins': doc.get('coins'),
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

  static Future<void> updateCoinsToFirebase() async {
  final prefs = await SharedPreferences.getInstance();
  String? playerJson = prefs.getString('player');
  if (playerJson != null) {
    Map<String, dynamic> playerData = jsonDecode(playerJson);
    int currentCoins = playerData['coins'] ?? 0;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('players')
          .doc(user.uid)
          .update({
        'coins': currentCoins,
      });
    }
  }
}
}
