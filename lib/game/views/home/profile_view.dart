import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/models/player_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 100),
            Text('Name: ${user?.displayName ?? 'Unknown'}'),
            Text('Email: ${user?.email ?? 'Unknown'}'),
            ButtonOne(
                onButtonPressed: () async {
                  await PlayerModel.saveUserFirestores();
                  
                },
                title: 'Sauvegarder')
          ],
        ),
      ),
    );
  }
}
