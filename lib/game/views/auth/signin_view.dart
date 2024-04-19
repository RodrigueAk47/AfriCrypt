import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/views/auth/login_view.dart';
import 'package:africrypt/game/views/dashboard_view.dart';
import 'package:africrypt/models/player_model.dart';
import 'package:africrypt/models/season_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          margin: screenWidth > 800
              ? EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.2,
                  right: MediaQuery.of(context).size.width * 0.2,
                  top: 25,
                  bottom: 20)
              : const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Se Connecter',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 100),
              ButtonOne(
                onButtonPressed: () async {
                  await PlayerModel.signInWithGoogle();
                  if (FirebaseAuth.instance.currentUser != null) {
                    await PlayerModel.restoreFromFirestoreToSharedPreferences();
                    await Season.restoreLastUnlockedSeason();
                  }

                  final playerData =
                      await PlayerModel.loadFromSharedPreferences();
                  if (playerData != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()));
                  }
                },
                title: 'Google',
                logo: Icons.online_prediction,
              ),
              const SizedBox(height: 25),
              ButtonOne(
                  onButtonPressed: () {
                    PlayerModel.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginView()),
                    );
                  },
                  title: 'Passer'),
            ],
          ),
        ),
      ),
    );
  }
}
