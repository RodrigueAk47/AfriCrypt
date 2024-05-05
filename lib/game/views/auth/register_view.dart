import 'package:africrypt/features/string_feature.dart';
import 'package:africrypt/game/components/button_component.dart';
import 'package:africrypt/game/components/text_field_component.dart';
import 'package:africrypt/main.dart';
import 'package:africrypt/models/player_model.dart';
import 'package:flutter/material.dart';

import '../../../features/auth_gardian.dart';
import 'login_view.dart';

class RegisterAuth extends StatefulWidget {
  const RegisterAuth({super.key});

  @override
  State<RegisterAuth> createState() => _RegisterAuthState();
}

class _RegisterAuthState extends State<RegisterAuth> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0.0,

      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/saisons/saison_1/saison.png'),
                fit: BoxFit.cover)),
        child: Container(
          margin: screenWidth > 800
              ? EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.2,
              right: MediaQuery.of(context).size.width * 0.2,
              top: 25,
              bottom: 20)
              : const EdgeInsets.only(
              left: 10, right: 10, top: 20, bottom: 20),
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding:  EdgeInsets.only(top: responsive<double>(context, 130, 70)),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0), // Add padding to make the text look better
                      decoration: BoxDecoration(
                        color: globalColor, // This is the background color
                        borderRadius: BorderRadius.circular(15), // This makes the corners rounded
                      ),
                      child: const Text(
                        'S\'enregistrer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,// This is the color of the text
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    TextFieldGame(
                      hintText: 'Votre addresse mail',
                      controller: emailController,
                    ),
                    const SizedBox(height: 25),
                    TextFieldGame(
                      obscurText: true,
                      hintText: 'Votre mot de passe',
                      controller: passwordController,
                    ),
                    const SizedBox(height: 25),
                    ButtonOne(
                      onButtonPressed: () async {
                        if (await isInternetConnected()) {
                          String? email = emailController.text.trim();
                          String? password = passwordController.text.trim();

                          if (!isValidEmail(email)) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: globalColor,
                              content: const Text('Email invalide.'),
                              action: SnackBarAction(
                                label: 'ok',
                                onPressed: () {
// Code to execute.
                                },
                              ),
                            ));
                            return;
                          }

                          if (!isValidPassword(password)) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: globalColor,
                              content: const Text('Mot de passe invalide.'),
                              action: SnackBarAction(
                                label: 'ok',
                                onPressed: () {
// Code to execute.
                                },
                              ),
                            ));
                            return;
                          }

                          String? errorMessage =
                          (await PlayerModel.signUpWithEmail(email, password));
                          if (errorMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: globalColor,
                              content: Text(errorMessage),
                              action: SnackBarAction(
                                label: 'ok',
                                onPressed: () {
// Code to execute.
                                },
                              ),
                            ));
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginView()));
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
                      title: 'Cest bon !',
                    ),
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
