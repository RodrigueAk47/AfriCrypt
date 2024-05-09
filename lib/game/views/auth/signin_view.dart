import 'package:africrypt/Models/episodes_model.dart';
import 'package:africrypt/Models/game_model.dart';
import 'package:africrypt/Models/season_model.dart';
import 'package:africrypt/features/string_feature.dart';
import 'package:africrypt/game/components/alert_component.dart';
import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/components/text_field_component.dart';
import 'package:africrypt/game/views/auth/login_view.dart';
import 'package:africrypt/game/views/auth/register_view.dart';
import 'package:africrypt/game/views/dashboard_view.dart';
import 'package:africrypt/main.dart';
import 'package:africrypt/models/player_model.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/main.jpg'),
                fit: BoxFit.cover)),
        child: Container(
          margin: screenWidth > 800
              ? EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.2,
                  right: MediaQuery.of(context).size.width * 0.2,
                  top: 25,
                  bottom: 20)
              : const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.only(top: responsive<double>(context, 130, 70)),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(
                          8.0), // Add padding to make the text look better
                      decoration: BoxDecoration(
                        color: globalColor, // This is the background color
                        borderRadius: BorderRadius.circular(
                            15), // This makes the corners rounded
                      ),
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight:
                              FontWeight.bold, // This is the color of the text
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    TextFieldGame(
                        hintText: 'Votre addresse mail',
                        controller: emailController),
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
                            final String password =
                                passwordController.text.trim();

                            String? signInResult =
                                (await PlayerModel.signInWithEmail(
                                    email, password));
                            if (signInResult == null) {
                              progress(context);

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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
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
                              fontSize: 20,
                              color: Colors.white,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
