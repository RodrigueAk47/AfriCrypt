import 'package:africrypt/Models/episodes_model.dart';
import 'package:africrypt/Models/game_model.dart';
import 'package:africrypt/Models/season_model.dart';
import 'package:africrypt/features/string_feature.dart';

import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/components/text_field_component.dart';
import 'package:africrypt/game/views/auth/login_view.dart';
import 'package:africrypt/game/views/auth/register_view.dart';
import 'package:africrypt/game/views/dashboard_view.dart';
import 'package:africrypt/main.dart';
import 'package:africrypt/models/player_model.dart';

import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
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
              TextFieldGame(
                  hintText: 'Votre addresse mail', controller: emailController),
              const SizedBox(height: 25),
              TextFieldGame(
                hintText: 'Votre mot de passe',
                obscurText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 25),
              ButtonOne(
                  onButtonPressed: () async {
                    if (await isInternetConnected()) {
                      final String email = emailController.text.trim();
                      final String password = passwordController.text.trim();

                      String? signInResult =
                          (await PlayerModel.signInWithEmail(email, password));
                      if (signInResult == null) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(
                                      backgroundColor: globalColor,
                                    ),
                                    const Text(" Chargement..."),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                        try {
                          await PlayerModel
                              .restoreFromFirestoreToSharedPreferences();
                          await Season.restoreLastUnlockedSeason();
                          await Episode.restoreLastUnlockedEpisodes();
                          await GameModel.restoreHintFromFirestore();
                        } catch (e) {
                          // Handle error
                        } finally {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()),
                          ); // Close the dialog
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(signInResult),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {},
                          ),
                        ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Pas de connexion Internet'),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      ));
                    }
                  },
                  title: "Se connecter avec Email"),
              const SizedBox(height: 25),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterAuth()),
                    );
                  },
                  child: const Text('Pas encore de compte ?',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.purple,
                      ))),
              const SizedBox(height: 6),
              ButtonOne(
                  onButtonPressed: () {
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
