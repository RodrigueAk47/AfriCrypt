import 'package:africrypt/game/components/alert_component.dart';
import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/views/auth/signin_view.dart';
import 'package:africrypt/models/player_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PlayerModel? player;

  @override
  void initState() {
    super.initState();
    print('succes');
    PlayerModel.loadFromSharedPreferences().then((loadedPlayer) {
      setState(() {
        player = loadedPlayer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Mon Profil',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 40,
            ),
            if (player != null)
              Center(
                child: Container(
                  margin: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Image.asset(
                    'assets/images/perso/${player?.gender == false ? 'boy' : 'girl'}.png',
                    scale: 5,
                  ),
                ),
              ),
            Text('${player?.name}',
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            user != null
                ? ButtonOne(
                    onButtonPressed: () async {
                      progress(context);

                      try {
                        await PlayerModel.signOutWithEmail();
                        await PlayerModel.deletePlayerData();
                      } catch (e) {
                        // Handle error
                      } finally {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()));
                      }
                    },
                    title: 'Se deconnecter')
                : ButtonOne(
                    onButtonPressed: () async {
                      progress(context);
                      try {
                        await PlayerModel.deletePlayerData();
                      } catch (e) {
                        // Handle error
                      } finally {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()));
                      }
                    },
                    title: 'Supprimer mes données'),
          ],
        ),
      ),
    );
  }
}
