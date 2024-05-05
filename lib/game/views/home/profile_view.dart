import 'package:africrypt/core/theme.dart';
import 'package:africrypt/features/string_feature.dart';
import 'package:africrypt/game/components/alert_component.dart';
import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/views/auth/signin_view.dart';
import 'package:africrypt/main.dart';
import 'package:africrypt/models/player_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PlayerModel? player;
  bool show = false;
  bool isVerificationEmailSent = false;

  @override
  void initState() {
    super.initState();
    PlayerModel.loadFromSharedPreferences().then((loadedPlayer) {
      setState(() {
        player = loadedPlayer;
      });
    });
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser!.reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Mon Profil',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            if (player != null)
              Center(
                child: Container(
                  margin: const EdgeInsets.all(50),
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
            const SizedBox(height: 10),
            Center(
              child: Container(
                color: Colors.blue[80],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.monetization_on, color: globalColor),
                    const SizedBox(
                        width:
                            10), // Vous pouvez ajuster l'espace entre l'icône et le texte
                    Text(
                      'Solde : ${player?.coins}',
                      style: const TextStyle(fontSize: 19),
                    ),
                  ],
                ),
              ),
            ),
            if (defaultTargetPlatform == TargetPlatform.android &&
                user != null &&
                user.emailVerified == false)
              TextButton(
                  onPressed: () async {
                    if (!isVerificationEmailSent) {
                      user.sendEmailVerification();
                      isVerificationEmailSent = true;
                    }
                    setState(() {
                      show = true;
                    });
                  },
                  child: show
                      ? FutureBuilder(
                          future: Future.delayed(const Duration(seconds: 2)),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return LinearProgressIndicator(
                                color: globalColor,
                              );
                            } else {
                              return const Text(
                                  'Un code été envoyé sur votre mail');
                            }
                          },
                        )
                      : const Text('Veuillez valider votre addresse mail')),
            const SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(
                  left: responsive<double>(context, 200, 5),
                  right: responsive<double>(context, 200, 5),
                  top: responsive<double>(context, 10, 5),
                  bottom: responsive<double>(context, 10, 5)),
              child: user != null
                  ? ButtonOne(
                      title: 'Se deconnecter',
                      onButtonPressed: () async {
                        progress(context);

                        try {
                          await PlayerModel.signOutWithEmail();
                          await PlayerModel.deletePlayerData();
                          GameTheme.refreshGlobalColor();
                        } catch (e) {
                          // Handle error
                        } finally {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignIn()));
                        }
                      },
                    )
                  : ButtonOne(
                      onButtonPressed: () async {
                        progress(context);
                        try {
                          await PlayerModel.deletePlayerData();
                          GameTheme.refreshGlobalColor();
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
            )
          ],
        ),
      ),
    );
  }
}
